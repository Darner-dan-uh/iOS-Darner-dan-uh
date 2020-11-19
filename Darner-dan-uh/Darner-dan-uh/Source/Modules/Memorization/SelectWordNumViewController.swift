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

final class SelectWordNumViewController: UIViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension SelectWordNumViewController {
    private func bindAction() {
        minusWordNumBtn.rx.tap
            .map { self.editWordCount(self.minusWordNumBtn, self.wordNum)}
            .bind(onNext: { num in
                self.wordNumLbl.text = String(num)
            }).disposed(by: disposeBag)
        
        plusWordNumBtn.rx.tap
            .map { self.editWordCount(self.plusWordNumBtn, self.wordNum)}
            .bind(onNext: { num in
                self.wordNumLbl.text = String(num)
            }).disposed(by: disposeBag)
        
        backVCBtn.rx.tap
            .bind(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        nextVCBtn.rx.tap
            .map { /* wordNum을 서버로 보내야함  */ }
            .bind(onNext: {
                let vc: TestTableViewController = self.makeVC(identifier: ViewControllerName.testTableVC)
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func editWordCount(_ sender: UIButton,_ num: Int) -> Int {
        if num <= 0 || num >= 100 { return num }
        switch sender.tag {
        case 0:
            wordNum = num - 1
            return wordNum
            
        case 1:
            wordNum = num + 1
            return num + 1
            
        default:
            return 0
        }
    }   
}
