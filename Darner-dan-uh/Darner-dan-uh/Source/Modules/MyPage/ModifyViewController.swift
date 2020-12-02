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
    @IBOutlet weak var modifyBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = MypageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "마이페이지"
        
        nickNameTxtField.clearButtonMode = .whileEditing

        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        modifyBtn.buttonStyle()
        nickNameTxtField.underLine()
        
        
    }

    func bindViewModel() {
        let input = MypageViewModel.Input.init(nickName: nickNameTxtField.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input)
        
        output.result.emit(onCompleted: { [unowned self] in
            self.nextView(identifire: "enterPw")
        }).disposed(by: disposeBag)
        
    }
    
    func bindAction() {
        //modifyBtn.rx.tap.
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









