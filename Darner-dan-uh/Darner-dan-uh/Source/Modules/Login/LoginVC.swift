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

final class LoginVC: UIViewController {
    
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
        idTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.idTextFieldSubject).disposed(by: disposeBag)
        pwTextField.rx.text.map { $0 ?? "" }.bind(to: viewModel.pwTextFieldSubject).disposed(by: disposeBag)
        viewModel.isValid().subscribe(onNext :{ value in
            self.loginBtn.layer.borderColor = value ? UIColor.customPink.cgColor : UIColor.black.cgColor
            self.loginBtn.backgroundColor = value ? .customPink : .white
            value ? self.loginBtn.setTextColor(color: .white) : self.loginBtn.setTextColor(color: .black)
            self.loginBtn.isUserInteractionEnabled = value
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func autoLogin(_ sender: UIButton) {
        /// refactor
        if autoLoginBtn.isSelected {
            autoLoginBtn.setImage(UIImage(named: "Icon ionic-ios-checkmark-circle"), for: .selected)
            autoLoginFlag = true
        } else {
            autoLoginBtn.setImage(UIImage(named: "Icon material-radio-button-unchecked"), for: .normal)
            autoLoginFlag = false
        }
        autoLoginBtn.isSelected = !autoLoginBtn.isSelected
    }
    
    
    @IBAction func popVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
