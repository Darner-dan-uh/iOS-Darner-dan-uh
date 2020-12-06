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
        
        bindViewModel()
        
        let alret = UIAlertController(title: "로그아웃 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)

        alret.addAction(UIAlertAction(title: "네", style: .default, handler: nil))
        alret.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: nil))
        
        present(alret, animated: true, completion: nil)

        
    }
//
//    func bindAction() {
//        modifyBtn.rx.tap.flatMap{ (request: DarnerAPI) -> Observable<MypageModel> in
//            return DarnerAPIClient.shared.networkingResult(from: request)
//        }
//        .subscribe
//    }
    
    func bindAction() {
        logOutBtn.rx.tap
            .map { self.presentAlert(message: "로그아웃 하시겠습니까?", style: .alert, title: "네", actionStyle: .default, handler: nil, secTitle: "아니요", secActionStyle: .cancel, secHandler: nil)}
            .subscribe()
            .disposed(by: disposeBag)
        
        modifyBtn.rx.tap
            .map{ let controller = self.navigationController?.viewControllers
                self.navigationController?.viewControllers = controller!
                self.navigationController?.popViewController(animated: true)
        }
        
        characterBtn.rx.tap
            .subscribe(onNext: { _ in
                let vc = self.makeVC(storyBoardName: .myPage, identifier: .myCharacterVC)
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func nextVC(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "modify") else { return }
        self.present(nextVC, animated: true)
        self.dismiss(animated: true)
    }
}
