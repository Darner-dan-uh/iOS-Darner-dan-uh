//
//  SelectWordNumVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/28.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class SelectWordNumVC: UIViewController {
    
    var wordNum = 10
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var backVCBtn: UIButton!
    @IBOutlet weak var minusWordNumBtn: UIButton!
    @IBOutlet weak var plusWordNumBtn: UIButton!
    @IBOutlet weak var nextVCBtn: UIButton!
    @IBOutlet weak var wordNumLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
    }
}

extension SelectWordNumVC {
    func bindAction() {
        backVCBtn.rx.tap
            .
        
        minusWordNumBtn.rx.tap
            .map { self.minusNum(self.wordNum) }
            .bind(onNext: { num in
                self.wordNumLbl.text = String(num)
            }).disposed(by: disposeBag)
        
        plusWordNumBtn.rx.tap
            .map { self.plusNum(self.wordNum) }
            .bind(onNext: { num in
                self.wordNumLbl.text = String(num)
            }).disposed(by: disposeBag)
    }
    
    private func minusNum(_ num: Int) -> Int {
        if num <= 0 {
            return num
        } else {
            wordNum = num - 1
            return num - 1
        }
    }
    
    private func plusNum(_ num: Int) -> Int {
        if num >= 100 {
            return num
        } else {
            wordNum = num + 1
            return num + 1
        }
    }
}
