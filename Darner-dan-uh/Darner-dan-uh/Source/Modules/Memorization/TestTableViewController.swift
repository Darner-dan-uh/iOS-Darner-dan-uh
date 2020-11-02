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

class TestTableViewController: UIViewController {
    let wordCellArrObservable: PublishSubject<[DecodeWordCell]>! = .init()
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
            let firstAction = self.makeAlertAction(title: "더 공부할게요", style: .destructive, handler: nil)
            let secAction = self.makeAlertAction(title: "준비됐습니다", style: .default) { _ in
                let vc: TestViewController = self.makeVC(identifier: ViewControllerName.testVC)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            self.presentAlert(message: "단어 시험을 볼 준비가 됐나요?", style: .alert, firstAction: firstAction, secAction: secAction)
        }.subscribe().disposed(by: disposeBag)
        
        popVCBtn.rx.tap
            .map {
                guard self.navigationController != nil else { return }
                var navigationArray = self.navigationController?.viewControllers
                navigationArray!.remove(at: (navigationArray?.count)! - 2)
                self.navigationController?.viewControllers = navigationArray!
                self.navigationController?.popViewController(animated: true)
            }
            .subscribe().disposed(by: disposeBag)
    }
    
    private func bindUI() {
        self.wordTypeLbl.text = MemorizationViewController.wordType
        self.testBtn.layer.borderColor = UIColor.customPink.cgColor
        self.tabBarController?.tabBar.isHidden = false
    }
}
