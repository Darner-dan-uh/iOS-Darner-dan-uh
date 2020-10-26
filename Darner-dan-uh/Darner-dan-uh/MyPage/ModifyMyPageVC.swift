//
//  ModifyMyPageVC.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/10/16.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class ModifyMyPageVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var enterNickNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var enterPasswordLabel: UILabel!
    @IBOutlet weak var modifyBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textfieldBorderLineStyle(_ nameOfTextField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: nameOfTextField.frame.size.height - width, width: nameOfTextField.frame.size.width, height: nameOfTextField.frame.size.height)
        
        border.borderWidth = width
        nameOfTextField.layer.addSublayer(border)
        nameOfTextField.layer.masksToBounds = true
        
    }

}
