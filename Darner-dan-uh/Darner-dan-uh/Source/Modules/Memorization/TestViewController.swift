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
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
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
    }
    
    private func bindUI() {
        let words: Observable<Welcome> = DarnerAPIClient.shared.networkingResult(from:.wordTest)
        words.map { $0.content }
            .bind(to: collectionView.rx.items(cellIdentifier: TestCollectionViewCell.cellName, cellType: TestCollectionViewCell.self)) { idx, model, cell in
                if idx % 2 == 0 {
                    cell.wordTestLbl.text = model.korea
                } else {
                    cell.wordTestLbl.text = model.english
                }
            }.disposed(by: disposeBag)
    }
}
