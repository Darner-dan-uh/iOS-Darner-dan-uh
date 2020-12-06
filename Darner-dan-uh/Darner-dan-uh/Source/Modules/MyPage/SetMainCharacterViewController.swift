//
//  SetMainCharacterViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/11.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class SetMainCharacterViewController: UIViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var characterNameLbl: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var levelLbl: UILabel!
    @IBOutlet weak var setProfileBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        // Do any additional setup after loading the view.
    }
}

extension SetMainCharacterViewController {
    private func bindAction() {
        cancelBtn.rx.tap
            .subscribe { _ in
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        setProfileBtn.rx.tap.map { self.characterImageView.image }
            .subscribe(onNext: { (img) in
                UserDefaults.standard.setValue(img, forKey: "image")
                self.presentingViewController?.presentingViewController?
                    .dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
}
