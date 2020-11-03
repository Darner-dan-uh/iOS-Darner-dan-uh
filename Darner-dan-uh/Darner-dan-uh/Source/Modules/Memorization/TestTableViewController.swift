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
            self.presentAlert(message: "단어 시험을 볼 준비가 됐나요?", style: .alert, title: "더 공부할게요", actionStyle: .destructive, handler: nil, secTitle: "준비됐습니다", secActionStyle: .default) { _ in
                let vc: TestViewController = self.makeVC(identifier: ViewControllerName.testVC)
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
        self.wordTypeLbl.text = MemorizationViewController.obserbeWordType
        self.testBtn.layer.borderColor = UIColor.customPink.cgColor
        self.tabBarController?.tabBar.isHidden = false
    }
}
