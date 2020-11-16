//
//  ModifyViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ModifyViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var nickNameTxtField: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTxtFiled: UITextField!
    @IBOutlet weak var modifyBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = MypageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "마이페이지"
        
        nickNameTxtField.clearButtonMode = .whileEditing
        passwordTxtFiled.clearButtonMode = .whileEditing

        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        modifyBtn.buttonStyle()
        nickNameTxtField.underLine()
        passwordTxtFiled.underLine()
        
        passwordTxtFiled.isSecureTextEntry = true
        
    }

    func bindViewModel() {
        let input = MypageViewModel.Input(userName: nickNameTxtField.rx.text.orEmpty.asDriver(), userPw: passwordTxtFiled.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input)
        
    }
    
    func bindAction() {
        modifyBtn.rx.tap
            .map{ let controller =
                self.navigationController?.viewControllers
                self.navigationController?.viewControllers = controller!
                self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func nextView(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "enterPw") else { return }
        self.present(nextVC, animated: true)
        self.dismiss(animated: true)
    }
}

extension UITextField {
    func underLine() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.customGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIButton {
    func buttonStyle() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.customPink.cgColor
        self.layer.cornerRadius = 15
    }
}









