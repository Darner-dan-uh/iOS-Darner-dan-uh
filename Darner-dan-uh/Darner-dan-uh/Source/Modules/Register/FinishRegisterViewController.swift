//
//  FinishRegisterViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/21.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class FinishRegisterViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var popToMainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
}

extension FinishRegisterViewController {
    private func bindAction() {
        self.startBtn.rx.tap
            .subscribe { _ in
                guard var controllers = self.navigationController?.viewControllers else { return }
                let count = controllers.count
                if count > 2 {
                    controllers.removeSubrange(1...count-2)
                }
                self.navigationController?.viewControllers = controllers
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        func bindAction() {
            self.popToMainBtn.rx.tap
                .subscribe { _ in
                    guard var controllers = self.navigationController?.viewControllers else { return }
                    let count = controllers.count
                    if count > 2 {
                        controllers.removeSubrange(1...count-2)
                    }
                    self.navigationController?.viewControllers = controllers
                    self.navigationController?.popViewController(animated: true)
                }.disposed(by: disposeBag)
        }
    }
}


