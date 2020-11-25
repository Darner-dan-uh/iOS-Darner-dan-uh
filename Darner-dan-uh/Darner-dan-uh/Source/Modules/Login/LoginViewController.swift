//
//  LoginVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/14.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    var autoLoginFlag: Bool! = false
    let viewModel: LoginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var autoLoginLblBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var popVCBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        bind()
    }
}



extension LoginViewController {
    private func bindAction() {
        loginBtn.rx.tap
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .withLatestFrom(Observable.combineLatest(self.idTextField.rx.text.orEmpty, self.pwTextField.rx.text.orEmpty))
            .map { DarnerAPI.login(userId: $0.0, password: $0.1) }
            .flatMap { (request:DarnerAPI) -> Observable<LoginResultModel> in
                return DarnerAPIClient.shared.networkingResult(from: request)
            }
            .subscribe { (model:LoginResultModel) in
                if model.message == "UnAuthorized" {
                    self.loginBtn.shake()
                    return
                }
                //                    b.message 키체인에 저장
                let vc = self.makeVC(identifier: ViewControllerName.tabbarVC)
                vc.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } onError: { (_:Error) in
                self.loginBtn.shake()
            }.disposed(by: self.disposeBag)
        
        Observable.merge(
            autoLoginBtn.rx.tap.map {},
            autoLoginLblBtn.rx.tap.map {}
        ).map { self.autoLoginBtn.isSelected.toggle() }
        .map { if self.autoLoginBtn.isSelected == true {
            self.autoLoginBtn.setImage(UIImage(named: "Icon ionic-ios-checkmark-circle"), for: .selected)
        } else {
            self.autoLoginBtn.setImage(UIImage(named: "Icon material-radio-button-unchecked"), for: .normal)
        }}
        .subscribe()
        .disposed(by: disposeBag)
        
        popVCBtn.rx.tap
            .subscribe { _ in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
    
    private func bind() {
        let input = LoginViewModel.Input.init(idTextFieldSubject: idTextField.rx.text.orEmpty.asObservable(), pwTextFieldSubject: pwTextField.rx.text.orEmpty.asObservable())
        
        let output = viewModel.transform(input)
        
        output.result.drive (onNext:{ b in
            self.loginBtn.layer.borderColor = b ? UIColor.customPink.cgColor : UIColor.black.cgColor
            self.loginBtn.backgroundColor = b ? .customPink : .white
            b ? self.loginBtn.setTextColor(color: .white) : self.loginBtn.setTextColor(color: .black)
            self.loginBtn.isUserInteractionEnabled = b
        }).disposed(by: disposeBag)
    }
}

