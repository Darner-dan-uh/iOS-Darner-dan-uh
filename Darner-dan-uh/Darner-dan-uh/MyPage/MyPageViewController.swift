//
//  MypageVC.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/10/14.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class MypageVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var modifyProfileBtn: UIButton!
    @IBOutlet weak var selectCharacterBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //프로필 사진 둥글게
        profileImage.layer.cornerRadius = 55
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.clear.cgColor
        profileImage.clipsToBounds = true
        //프로필 사진 테두리
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.black.cgColor
        //버튼 테두리 둥글게
        modifyProfileBtn.layer.cornerRadius = 15
        selectCharacterBtn.layer.cornerRadius = 15
        
    
    }
    
    
}

extension UIColor {

  class var mainColor: UIColor {
    return UIColor(red: 253.0 / 255.0, green: 125.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0)
  }
    
}





  

