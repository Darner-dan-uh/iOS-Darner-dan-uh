//
//  TestTableViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/01.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class TestTableViewController: UIViewController {
    var wordTypeStr: String!
    var wordTypeInt: Int!
    var wordNum: Int!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var wordTypeLbl: UILabel!
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var popVCBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        bindUI()
        // Do any additional setup after loading the view.
    }
    
}

extension TestTableViewController {
    private func bindAction() {
        testBtn.rx.tap.map {
            self.presentAlert(message: "단어 시험을 볼 준비가 됐나요?", style: .alert, title: "더 공부할게요", actionStyle: .destructive, handler: nil, secTitle: "준비됐습니다", secActionStyle: .default) { _ in
                let vc: TestViewController = self.makeVC(storyBoardName: .memo, identifier: .testVC)
                vc.wordnum = self.wordNum
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }.subscribe()
        .disposed(by: disposeBag)
        
        popVCBtn.rx.tap
            .take(1)
            .map {
                self.navigationController?.popViewController(animated: true)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
        self.wordTypeLbl.text = self.wordTypeStr
        self.testBtn.layer.borderColor = UIColor.customPink.cgColor
        self.tabBarController?.tabBar.isHidden = false
        
        let words: Observable<WordModel> = DarnerAPIClient.shared.networkingResult(from: .wordGenre(word_id: String(self.wordTypeInt), number: String(self.wordNum)))
        words.map { $0.content! }
            .bind(to: tableView.rx.items(cellIdentifier: WordCell.cellName, cellType: WordCell.self)) { idx, model, cell in
                cell.wordEnglishMeanLbl.text = model.english
                cell.wordKoreanMeanLbl.text = model.korea
            }.disposed(by: disposeBag)
    }
    
}
