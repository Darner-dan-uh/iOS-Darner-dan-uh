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
    var wordType: String!
    
    static var obserbeWordType: String! { // 저장되있던 wordType과 string이 같다면 전에 선택했던 것이기 떄문에 굳이 단어 선택을 안해도 됨 -> 바로 testTableVC로 푸쉬
        didSet {}
        willSet {}
    }
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var memorizeTapItem: UINavigationItem!
    @IBOutlet weak var myPageBtn: UIButton!
    @IBOutlet weak var lawBtn: UIButton!
    @IBOutlet weak var traditionBtn: UIButton!
    @IBOutlet weak var artBtn: UIButton!
    @IBOutlet weak var harborBtn: UIButton!
    @IBOutlet weak var agricultureBtn: UIButton!
    @IBOutlet weak var militaryBtn: UIButton!
    @IBOutlet weak var electricalEnergyBtn: UIButton!
    @IBOutlet weak var coalBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindAction()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension MemorizationViewController {
    private func bindUI() {
//        memorizeTapItem.≥÷÷≥¿÷title.
    }
    
    private func bindAction() {
        Observable.merge(lawBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "법률" },
                         traditionBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "전통"},
                         artBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "예술"},
                         harborBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "항구"},
                         agricultureBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "농업"},
                         militaryBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "군사"},
                         electricalEnergyBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "전력"},
                         coalBtn.rx.tap.map { MemorizationViewController.obserbeWordType = "석탄"}
        ).subscribe { _ in
            let vc = self.makeVC(identifier: ViewControllerName.selectwordNumVC)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        
        
        myPageBtn.rx.tap
            .subscribe({ _ in
                let vc = self.makeVC(identifier: ViewControllerName.myCharacterVC)
                self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
