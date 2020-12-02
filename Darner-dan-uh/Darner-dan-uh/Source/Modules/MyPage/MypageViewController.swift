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
    //@IBOutlet weak var logOutBtn: UIButton!
    
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
    
   
    
    func bindViewModel() {
        let input = SeeMypageViewModel.Input.init(doneTap: modifyBtn.rx.tap.asDriver())
        let output = viewModel.transform(input)
        
        output.result.emit(onCompleted: { [unowned self] in
            self.nextView(identifire: "modify")
        }).disposed(by: disposeBag)
    }
    
}


extension UIViewController {
    func nextView(identifire: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifire)
        navigationController?.pushViewController(viewController!, animated: true)
    }
}
