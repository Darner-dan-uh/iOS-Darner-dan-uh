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

final class RegisterVC: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = RegisterViewModel()

    @IBOutlet weak var doubleCheckBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var popVCBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    @IBAction func popVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func bindUI() {
        //FIX- doublecheck 
        nameTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.nameTextFieldSubject).disposed(by: disposeBag)
        idTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.idTextFieldSubject).disposed(by: disposeBag)
        pwTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.pwTextFieldSubject).disposed(by: disposeBag)
        viewModel.isvalid().subscribe(onNext: { value in
            self.registerBtn.layer.borderColor = value ? UIColor.customPink.cgColor : UIColor.black.cgColor
            self.registerBtn.backgroundColor = value ? .customPink : .white
            value ? self.registerBtn.setTextColor(color: .white) : self.registerBtn.setTextColor(color: .black)
            self.registerBtn.isEnabled = value
        }).disposed(by: disposeBag)
        idTextField.rx.text.orEmpty.map { self.isValid(email: $0)}.map {print($0)}
//            .map { self.doubleCheckBtn.isHidden = $0}
    }
}

extension RegisterVC {
    private func isValid(email: String) -> Bool {
        return !email.isEmpty || email == ""
    }
}

