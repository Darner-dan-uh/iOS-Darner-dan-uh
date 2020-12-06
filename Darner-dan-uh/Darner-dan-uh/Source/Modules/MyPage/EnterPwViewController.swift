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
    
    private let disposeBag = DisposeBag()
   // private let viewModel = MypageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nextBtn.buttonStyle()
        passwordTxtField.isSecureTextEntry = true
        
        passwordTxtField.underLine()
        password()
//        let alret = UIAlertController(title: "비밀번호 확인이 되었습니다!", message: "", preferredStyle: UIAlertController.Style.alert)
//        alret.addAction(UIAlertAction(title: "다음", style: .default, handler: nil))
//        present(alret, animated: true, completion: nil)
    }
    
    func password() {
        nextBtn.rx.tap
            .map{ self.passwordTxtField.text! }
            .map { DarnerAPI.verifyPassword(pw: $0)}
            .flatMap {request -> Observable<passwordModel> in
                return DarnerAPIClient.shared.networkingResult(from: request)
            }.subscribe { model in
                //print(model)
                self.passwordTxtField.text = model.password
            }.disposed(by: disposeBag)

        
//        password.asObservable().subscribe(onNext: { model in
//            self.passwordTxtField.text = model.password
//        }).disposed(by: disposeBag)
    }
}


