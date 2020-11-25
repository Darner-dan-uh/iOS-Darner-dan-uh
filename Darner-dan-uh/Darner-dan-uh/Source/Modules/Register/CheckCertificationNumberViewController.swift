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
    let viewModel = CheckCertificationNumberViewModel()
    
    @IBOutlet weak var previousVCBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var certificationNumberTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindAction()
    }
}

extension CheckCertificationNumberViewController {
    private func bindAction() {
        nextBtn.rx.tap
            .withLatestFrom(self.certificationNumberTxtField.rx.text)
            .map { DarnerAPI.verifywithemail(email: RegisterViewController.email, code: $0!) }
            .flatMap {(request: DarnerAPI) -> Observable<LoginResultModel> in
                DarnerAPIClient.shared.networkingResult(from: request)
            }
            .subscribe { _ in
                let vc = self.makeVC(identifier: .finishRegisterVC)
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } onError: { _ in
                self.nextBtn.shake()
            }.disposed(by: disposeBag)

        
        previousVCBtn.rx.tap
            .subscribe { _ in
                self.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
    
    private func bindUI() {
        let input = CheckCertificationNumberViewModel.Input.init(codeSubject: certificationNumberTxtField.rx.text.orEmpty.asObservable())
        
        let output = viewModel.transform(input)
        
        output.result.drive(onNext: { bool in
            bool ? self.nextBtn.setTextColor(color: .white) : self.nextBtn.setTextColor(color: .black)
            self.nextBtn.isUserInteractionEnabled = bool
            self.nextBtn.layer.borderColor = bool ? UIColor.customPink.cgColor : UIColor.black.cgColor
            self.nextBtn.backgroundColor = bool ? .customPink : .white
        }).disposed(by: disposeBag)
    }
}
