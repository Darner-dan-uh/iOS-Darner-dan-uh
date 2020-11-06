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
    let viewModel = LoginViewModel()
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
        bindUI()
    }
}

extension LoginViewController {
    private func bindAction() {
        popVCBtn.rx.tap
            .subscribe { _ in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        loginBtn.rx.tap
            .map { /* 서버 통신 */ }
            .map { /* 자동 로그인에 대한 처리 */}
            .subscribe { _ in
                let vc = self.makeVC(identifier: ViewControllerName.tabbarVC)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        Observable.merge(autoLoginBtn.rx.tap.map {}, autoLoginLblBtn.rx.tap.map {})
            .map { self.autoLoginBtn.isSelected.toggle() }
            .map { if self.autoLoginBtn.isSelected == true {
                self.autoLoginBtn.setImage(UIImage(named: "Icon ionic-ios-checkmark-circle"), for: .selected)
            } else {
                self.autoLoginBtn.setImage(UIImage(named: "Icon material-radio-button-unchecked"), for: .normal)
            }}
            .subscribe { _ in
                // keychain에 유저 정보 저장
            }.disposed(by: disposeBag)
    }
    
    private func bindUI() {
        idTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.idTextFieldSubject).disposed(by: disposeBag)
        pwTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.pwTextFieldSubject).disposed(by: disposeBag)
        viewModel.isValid().subscribe(onNext :{ value in
            self.loginBtn.layer.borderColor = value ? UIColor.customPink.cgColor : UIColor.black.cgColor
            self.loginBtn.backgroundColor = value ? .customPink : .white
            value ? self.loginBtn.setTextColor(color: .white) : self.loginBtn.setTextColor(color: .black)
            self.loginBtn.isUserInteractionEnabled = value
        }).disposed(by: disposeBag)
    }
}
