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
final class CheckCertificationNumberVC: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var certificationNumberTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }
    @IBAction func popVC(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextVCBtn(_ sender: Any) {
        // textfiled 값 post
        // sussess 면 다음 페이지
        // fail 이면 알람
        
        let vc = (storyboard?.instantiateViewController(identifier: "a"))!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CheckCertificationNumberVC {
    func bindUI() {
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
