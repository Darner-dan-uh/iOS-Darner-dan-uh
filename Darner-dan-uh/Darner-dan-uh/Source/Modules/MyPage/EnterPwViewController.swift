//
//  EnterPwViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class EnterPwViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancleBtn: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nextBtn.buttonStyle()
        passwordTxtField.isSecureTextEntry = true
        
        passwordTxtField.underLine()
        password()
        self.bindAction()
    }
    
    
    func password() {
        nextBtn.rx.tap
            .map{ self.passwordTxtField.text!}
            .map { DarnerAPI.verifyPassword(pw: $0)}
            .flatMap {request -> Observable<passwordModel> in
                return DarnerAPIClient.shared.networkingResult(from: request)
            }.subscribe { model in
                self.passwordTxtField.text = model.password
            }.disposed(by: disposeBag)
    }
    
    func bindAction() {
        nextBtn.rx.tap
            .subscribe({ _ in
                self.nextModal(indentifier: "modify")
            }).disposed(by: disposeBag)
        
//        cancleBtn.rx.tap
//            .subscribe(onNext: { _ in
//                self.backView(identifire: "mypage")
//            }).disposed(by: disposeBag)
        
       
    }
    
 
}

extension UIViewController {
    func nextView(identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(identifier: identifier)
        navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func nextModal(indentifier: String) {
        let viewController = self.storyboard?.instantiateViewController(identifier: indentifier)
        viewController?.modalPresentationStyle = .fullScreen
        present(viewController!, animated: true, completion: nil)
    }
}


