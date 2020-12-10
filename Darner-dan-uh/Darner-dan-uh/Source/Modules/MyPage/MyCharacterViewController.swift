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
    }
}

extension MyCharacterViewController {
    private func bindUI() {
        let os: Observable<LevelModel> = DarnerAPIClient.shared.networkingResult(from: .getLevel)
        
        os.subscribe(onNext: { model in
            self.userLevelLbl.text = String(model.level)
            switch model.level {
            case 0...2:
                self.nextEvolutionLbl.text = String(3)
            case 3...9:
                self.nextEvolutionLbl.text = String(10)
            case 10...29:
                self.nextEvolutionLbl.text = String(30)
            default:
                return
            }
        }).disposed(by: disposeBag)
        
        let id = UserDefaults.standard.value(forKey: "id") as! String
        userIdLbl.text = id
        
        if imageView.image == nil {
            imageView.image = UIImage(named: "핑크알")
        } else {
            let image = UserDefaults.standard.value(forKey: "image") as! UIImage
            imageView.image = image
        }
    }

    private func bindAction() {
        cancelBtn.rx.tap
            .subscribe({_ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        showCharacterVCBtn.rx.tap
            .map { _ in
                let vc = self.makeVC(storyBoardName: .myPage, identifier: .characterCollectionVC)
                self.present(vc, animated: true, completion: nil)
            }.subscribe()
            .disposed(by: disposeBag)
    }
}
