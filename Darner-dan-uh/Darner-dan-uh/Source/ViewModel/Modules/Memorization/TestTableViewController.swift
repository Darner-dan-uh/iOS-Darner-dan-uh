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
    private let disposeBag = DisposeBag()
    var wordnum: Int!
    
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
                let vc: TestViewController = self.makeVC(identifier: ViewControllerName.testVC)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }.subscribe()
        .disposed(by: disposeBag)
        
        popVCBtn.rx.tap
            .map {
                self.navigationController?.popViewController(animated: true)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
        self.wordTypeLbl.text = MemorizationViewController.wordType.rawValue
        self.testBtn.layer.borderColor = UIColor.customPink.cgColor
        self.tabBarController?.tabBar.isHidden = false
        
        let words: Observable<a> = DarnerAPIClient.shared.networkingResult(from: .wordGenre(word_id: "\(MemorizationViewController.wordType.asInt())", number: "\(String(describing: wordnum))"))
        words.map { [$0] }
            .bind(to: tableView.rx.items(cellIdentifier: WordCell.cellName, cellType: WordCell.self)) { _, result, cell in
            cell.wordEnglishMeanLbl.text = result.a
            }.disposed(by: disposeBag)
    }
}

struct a: Codable {
    var a: String
}
