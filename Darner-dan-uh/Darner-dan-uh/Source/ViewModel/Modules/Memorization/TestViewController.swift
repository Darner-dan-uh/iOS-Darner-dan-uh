//
//  TestViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/01.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class TestViewController: UIViewController {
    
    // realm에서 받아온 단어 배열 변수 생성
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var englishWordMeanLbl: UILabel!
    @IBOutlet weak var nextWordBtn: UIButton!
    @IBOutlet weak var popVCBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindAction()
        // Do any additional setup after loading the view.
    }
    
}

extension TestViewController {
    private func bindAction() {
        popVCBtn.rx.tap
            .map {
                self.presentAlert(message: "시험을 포기하시겠어요?", style: .alert, title: "포기하겠습니다", actionStyle: .destructive, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }, secTitle: "계속 할게요", secActionStyle: .default, secHandler: nil)
            }.subscribe().disposed(by: disposeBag)
        
        nextWordBtn.rx.tap
            .map { /* label 바꿔야함*/ }
    }
    
    private func bindUI() {
        // 단어 배열 변수가 마지막이면 alert 방출
        
        
        englishWordMeanLbl.text = "a" // realm에서 받아온 거 넣어주기
    }
}
