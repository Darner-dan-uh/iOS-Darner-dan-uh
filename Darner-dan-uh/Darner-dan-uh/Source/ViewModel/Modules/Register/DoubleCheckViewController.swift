//
//  DoubleCheckVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/14.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class DoubleCheckViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindAction()
    }
}

extension DoubleCheckViewController {
    private func bindAction() {
        nextBtn.rx.tap
            .map {/* 이메일 보냄*/ }
            .subscribe { _ in
                let vc = self.makeVC(identifier: ViewControllerName.checkCertificationVC)
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }

    private func bindUI() {
        emailTxtField.rx.text.orEmpty
            .map { self.checkEmail(email: $0) }
            .subscribe(onNext: { bool in
                bool ? self.nextBtn.setTextColor(color: .white) : self.nextBtn.setTextColor(color: .black)
                self.nextBtn.isUserInteractionEnabled = bool
                self.nextBtn.layer.borderColor = bool ? UIColor.customPink.cgColor : UIColor.black.cgColor
                self.nextBtn.backgroundColor = bool ? .customPink : .white
            }).disposed(by: disposeBag)
    }
    
    private func checkEmail(email: String) -> Bool {
        return !email.isEmpty
    }
}
