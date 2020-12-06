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
    @IBOutlet weak var idLbl: UILabel!
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
        
        viewProfile()
    }
    
    func viewProfile() {
        let mypage: Observable<MypageModel> = DarnerAPIClient.shared.networkingResult(from: .myProfile)
        mypage.asObservable().subscribe(onNext: { model in
            self.nickNameLbl.text = model.name
            self.idLbl.text = model.userId
        }).disposed(by: disposeBag)
    }
    
    func modifyProfile() {
        
        let mypage: Observable<a> = DarnerAPIClient.shared.networkingResult(from: .updateProfile(changeId: self.nickNameTxtField.text!))
        
        modifyBtn.rx.tap
            .map{ self.nickNameTxtField.text}
            .subscribe(onNext: { _ in
                mypage.asObservable().subscribe(onNext: { model in
                    self.nickNameTxtField.text = model.name
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        
//        
//            mypage.subscribe { (b) in
//                if b.code == 200 {
//    
//                }
//            } onError: { (<#Error#>) in
//                <#code#>
//            }
//      
    }
        

 

    
    func bindAction() {
        //modifyBtn.rx.tap.
    }



struct a: Codable {
    let code: Int
    let name: String
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









