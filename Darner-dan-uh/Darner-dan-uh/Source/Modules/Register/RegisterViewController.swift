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
    
    let disposeBag = DisposeBag()
    let viewModel = RegisterViewModel()
    
    @IBOutlet weak var sameIdNoticeLbl: UILabel!
    @IBOutlet weak var wrongPwLbl: UILabel!
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
        nameTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.nameTextFieldSubject)
            .disposed(by: disposeBag)
        
        idTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.idTextFieldSubject)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.pwTextFieldSubject)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.nameTextFieldSubject).disposed(by: disposeBag)
        
        idTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.idTextFieldSubject).disposed(by: disposeBag)
        
        pwTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.pwTextFieldSubject).disposed(by: disposeBag)
        
        viewModel.isValid().subscribe(onNext: { value in
            self.registerBtn.layer.borderColor = value ? UIColor.customPink.cgColor : UIColor.black.cgColor
            self.registerBtn.backgroundColor = value ? .customPink : .white
            value ? self.registerBtn.setTextColor(color: .white) : self.registerBtn.setTextColor(color: .black)
            self.registerBtn.isUserInteractionEnabled = value
        }).disposed(by: disposeBag)
        
        idTextField.rx.text
            .subscribe( { text in
                // text를 넣은 후 네트워킹해서 그 결과값을 sameIdNoticeLbl에 사용
            }).disposed(by: disposeBag)
        
        pwTextField.rx.text
            .map { self.viewModel.checkPw(PassWord: $0!)}
            .subscribe { bool in
                self.wrongPwLbl.isHidden = bool
            }.disposed(by: disposeBag)
        
        idTextField.rx.text.subscribe( { text in
            // text를 넣은 후 네트워킹해서 그 결과값을 sameIdNoticeLbl에 사용
        }).disposed(by: disposeBag)
        pwTextField.rx.text.map { self.viewModel.checkPw(PassWord: $0!)}.subscribe { bool in
            self.wrongPwLbl.isHidden = bool
        }.disposed(by: disposeBag)
    }
    
    private func bindAction() {
        popVCBtn.rx.tap
            .subscribe { _ in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        registerBtn.rx.tap.map {
            // 이름, 아이디, 비밀번호를 서버에 보냄
        }.subscribe { _ in
            let vc = self.makeVC(identifier: ViewControllerName.doubleCheckVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}
