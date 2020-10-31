//
//  MemorizationVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/08.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class MemorizationViewController: UIViewController {
    static var wordType: String!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var myPageBtn: UIButton!
    @IBOutlet var wordTypeBtns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        bindUI()
    }
}

extension MemorizationViewController {
    private func bindAction() {
        
    }
    
    private func bindUI() {
        myPageBtn.rx.tap.enumerated().map { idx in
//            MemorizationVC.wordType =
            print(idx.index)
            // 인덱스 값의 그걸 해줘야댐 -> 눌린 버튼의 인덱스를 확인해서 wordtype을 바꿔줘야함
            
        }.subscribe().disposed(by: disposeBag)
    }
}
