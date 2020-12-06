//
//  TestResultViewController.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/01.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class TestResultViewController: UIViewController {
    var arr: Observable<[TestRusultModel]>! = nil
    let disposeBag = DisposeBag()
    var correctCnt = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finishWordTestBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        bindUI()
        // Do any additional setup after loading the view.
    }
}

extension TestResultViewController {
    private func bindUI() {
        arr.bind(to: tableView.rx.items(cellIdentifier: WordResultCell.cellName, cellType: WordResultCell.self)) { _, result, cell in
            cell.wordMeanLbl.text = result.word
            if result.correct {
                cell.isCorrectLbl.text = "정답"
                cell.isCorrectLbl.textColor = .customBlack
                self.correctCnt += 1
            } else {
                cell.isCorrectLbl.text = "오답"
                cell.isCorrectLbl.textColor = .customPink
            }
            print(self.correctCnt)
        }.disposed(by: disposeBag)
        
        let id = UserDefaults.standard.value(forKey: "id") as! String
        let os: Observable<MessageModel> = DarnerAPIClient.shared.networkingResult(from: .savedata(id: id, count: self.correctCnt))
            .retry()
            
        os.subscribe(onNext: { model in
            if model.message == "success" {
                print("success")
            } else {
                print("fail")
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindAction() {
        finishWordTestBtn.rx.tap
            .map { _ in
                guard var controllers = self.navigationController?.viewControllers else { return }
                let count = controllers.count
                if count > 2 {
                    controllers.removeSubrange(1...count-2)
                }
                self.navigationController?.viewControllers = controllers
                self.navigationController?.popViewController(animated: true)
            }.subscribe()
            .disposed(by: disposeBag)
    }
}
