//
//  CharacterCollectionViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class CharacterCollectionViewController: UIViewController {
    private let disposeBag = DisposeBag()
    let arr: [Character] = [
        Character(name: "핑키", photo: "핑크알", level: 1, lock: ""),
        Character(name: "핑키핑키", photo: "핑크병아리", level: 2, lock: ""),
        Character(name: "레몬", photo: "노란알", level: 3, lock: ""),
        Character(name: "계란말이", photo: "노란병아리", level: 5, lock: ""),
        Character(name: "블루레몬", photo: "파란알", level: 10, lock: ""),
        Character(name: "블루베리", photo: "파란병아리", level: 30, lock: "")
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var firstCharacterBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var secCharacterBtn: UIButton!
    @IBOutlet weak var thirdCharacterBtn: UIButton!
    @IBOutlet weak var fourthCharacterBtn: UIButton!
    @IBOutlet weak var fifthCharacterBtn: UIButton!
    @IBOutlet weak var sixCharacterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
//        bindUI()
        // Do any additional setup after loading the view.
    }
}

extension CharacterCollectionViewController {
//    private func bindUI() {
//        Observable.just(arr)
//            .bind(to: collectionView.rx.items(cellIdentifier: CharacterCollectionViewCell.cellName, cellType: CharacterCollectionViewCell.self) { idx, model, cell in
//                cell.lbl.text = model.name
//                if model.level == 1 {
//
//                }
//                cell.imageView.image = UIImage(named: model.photo)
//        }).disposed(by:disposeBag)
//    }
    
    private func bindAction() {
        Observable.merge(firstCharacterBtn.rx.tap.map {},
                         secCharacterBtn.rx.tap.map {},
                         thirdCharacterBtn.rx.tap.map {},
                         fourthCharacterBtn.rx.tap.map {},
                         fifthCharacterBtn.rx.tap.map {},
                         sixCharacterBtn.rx.tap.map {}
        )
        .subscribe({ _ in
            let vc = self.makeVC(storyBoardName: .myPage, identifier: .setMainCharacterVC)
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        cancelBtn.rx.tap
            .subscribe { _ in
                self.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
}


struct Character {
    let name: String
    let photo: String
    let level: Int?
    let lock: String?
}
