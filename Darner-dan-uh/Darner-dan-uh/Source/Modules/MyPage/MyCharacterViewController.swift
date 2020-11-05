//
//  MyCharacterViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class MyCharacterViewController: UIViewController {
    let stringObs: Observable<String>! = nil // 서버 통신 후 받아온 문자
    let level: Int = 3 // 사용자 캐릭터의 레벨
    var a: Int? = 0
    private let disposeBag = DisposeBag()

    @IBOutlet weak var userIdLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userLevelLbl: UILabel!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var showCharacterVCBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindAction()
        // Do any additional setup after loading the view.
    }
}

extension MyCharacterViewController {
    private func bindUI() {
//        stringObs
//            .bind(to: self.userIdLbl.rx.text)
//            .disposed(by: disposeBag)
//
//        stringObs
//            .bind(to: self.userLevelLbl.rx.text)
//            .disposed(by: disposeBag)
//
       
        
        switch level {
        
        case 0...2:
            a = 3
        case 3...9:
            a = 10
        case 10...29:
            a = 30
        default:
            a = nil
        }
        
        nextEvolutionLbl.text = String(a!)
    }
    
    private func bindAction() {
        cancelBtn.rx.tap
            .bind(to: { _  in
                self.dismiss(animated: true, completion: nil)
            })
        
        showCharacterVCBtn.rx.tap
            .bind(to: { _ in
                let vc = makeVC(identifier: ViewControllerName.characterCollectionVC)
                self.present(vc, animated: true, completion: nil)
            })
    }
}
