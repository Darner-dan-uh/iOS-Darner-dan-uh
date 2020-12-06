//
//  MypageViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class MypageViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var modifyBtn: UIButton!
    @IBOutlet weak var characterBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = SeeMypageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = profileImage.frame.width/3
        characterBtn.buttonStyle()
        modifyBtn.buttonStyle()
        
    }


    
}


