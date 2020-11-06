//
//  CheckCertificationNumberVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/19.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class CheckCertificationNumberViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var popVCBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var certificationNumberTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
}

extension CheckCertificationNumberViewController {
    private func bindAction() {
        
        popVCBtn.rx.tap
            .subscribe { _ in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .map { //  textfiled 값 post
                // sussess 면 다음 페이지
                // fail 이면 알람
            }
            .subscribe { _ in
                let vc = self.makeVC(identifier: ViewControllerName.FinishRegisterVC)
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }
    
    private func bindUI() {
        certificationNumberTxtField.rx.text.orEmpty
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
