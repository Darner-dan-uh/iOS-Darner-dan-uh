//
//  RegisterVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/14.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class RegisterViewController: UIViewController {
    static var email: String!
    
    let disposeBag = DisposeBag()
    let viewModel = RegisterViewModel()
    
    @IBOutlet weak var sameIdNoticeLbl: UILabel!
    @IBOutlet weak var wrongPwLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var popVCBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindAction()
    }
}

extension RegisterViewController {
    private func bindUI() {
        
        let input = RegisterViewModel.Input.init(idTextFieldSubject: nameTextField.rx.text.orEmpty.asObservable(),
                                                 pwTextFieldSubject: idTextField.rx.text.orEmpty.asObservable(),
                                                 emailTextFieldSubject: pwTextField.rx.text.orEmpty.asObservable(),
                                                 nameTextField: emailTextField.rx.text.orEmpty.asObservable())
        
        let output = viewModel.transform(input)
        
        output.signal.drive(onNext: { b in
            self.registerBtn.layer.borderColor = b ? UIColor.customPink.cgColor : UIColor.black.cgColor
            self.registerBtn.backgroundColor = b ? .customPink : .white
            b ? self.registerBtn.setTextColor(color: .white) : self.registerBtn.setTextColor(color: .black)
            self.registerBtn.isUserInteractionEnabled = b
        }).disposed(by: disposeBag)
    }
    
    private func bindAction() {
        popVCBtn.rx.tap
            .subscribe { _ in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        registerBtn.rx.tap
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .withLatestFrom(Observable.combineLatest(self.idTextField.rx.text.orEmpty,
                                                     self.emailTextField.rx.text.orEmpty,
                                                     self.pwTextField.rx.text.orEmpty,
                                                     self.nameTextField.rx.text.orEmpty))
            .map {
                RegisterViewController.email = $0.1;
                return DarnerAPI.register(userId: $0.0, name: $0.3, email: $0.1, password: $0.2)
            }
            .flatMap { (request:DarnerAPI) -> Observable<MessageModel> in
                return DarnerAPIClient.shared.networkingResult(from: request)
            }
            .subscribe { model in
                if model.message == "success" {
                    let vc: CheckCertificationNumberViewController = self.makeVC(identifier: .checkCertificationVC)
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    self.registerBtn.shake()
                }
            } onError: { _ in
                self.registerBtn.shake()
            }
            .disposed(by: disposeBag)
    }
}
