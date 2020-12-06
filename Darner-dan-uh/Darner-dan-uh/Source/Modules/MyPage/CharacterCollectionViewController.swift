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
        // Do any additional setup after loading the view.
    }
}

extension CharacterCollectionViewController {
    private func bindUI() {
        
        
    }
    
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
