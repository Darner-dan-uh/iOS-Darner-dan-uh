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
    var arr: [TestRusultModel]?
    
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
        print(arr)
        Observable.from(optional: arr)
            .bind(to: tableView.rx.items(cellIdentifier: WordResultCell.cellName, cellType: WordResultCell.self)) { _, result, cell in
                cell.wordMeanLbl.text = result.word
                if result.correct {
                    cell.isCorrectLbl.text = "정답"
                    cell.isCorrectLbl.textColor = .customPink
                } else {
                    cell.isCorrectLbl.text = "오답"
                    cell.isCorrectLbl.textColor = .customGray
                }
            }.dispose()
    }
    
    private func bindAction() {
        finishWordTestBtn.rx.tap
            .map { var controller = self.navigationController?.viewControllers
                controller?.removeAll()
                self.navigationController?.viewControllers = controller!
                self.navigationController?.popViewController(animated: true)
            }.subscribe()
            .dispose()
    }
}
