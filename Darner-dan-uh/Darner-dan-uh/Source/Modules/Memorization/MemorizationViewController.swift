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
    
    var wordtupeStr: String!
    var wordtypeInt: Int!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension MemorizationViewController {
    private func bindAction() {
        Observable.merge(lawBtn.rx.tap.map { self.wordtupeStr = "과일"; self.wordtypeInt = 1 },
                         traditionBtn.rx.tap.map { self.wordtupeStr = "채소"; self.wordtypeInt = 2 },
                         artBtn.rx.tap.map { self.wordtupeStr = "항공"; self.wordtypeInt = 3 },
                         harborBtn.rx.tap.map { self.wordtupeStr = "항구"; self.wordtypeInt = 4 },
                         agricultureBtn.rx.tap.map { self.wordtupeStr = "농업"; self.wordtypeInt = 5 },
                         militaryBtn.rx.tap.map { self.wordtupeStr = "군사"; self.wordtypeInt = 6 },
                         electricalEnergyBtn.rx.tap.map { self.wordtupeStr = "전력"; self.wordtypeInt = 7 },
                         coalBtn.rx.tap.map { self.wordtupeStr = "석탄"; self.wordtypeInt = 8 }
        ).debounce(.nanoseconds(1), scheduler: MainScheduler.instance)
        .subscribe { _ in
            let vc = self.makeVC(storyBoardName: .memo, identifier: .selectwordNumVC) as SelectWordNumViewController
            vc.wordTypeStr = self.wordtupeStr
            vc.wordTypeInt = self.wordtypeInt
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)

        myPageBtn.rx.tap
            .observeOn(MainScheduler.instance)
            .map{ _ in
                let vc = self.makeVC(storyBoardName: .myPage, identifier: ViewControllerName.mypageVC)
                self.present(vc, animated: true, completion: nil)
            }.subscribe()
            .disposed(by: disposeBag)
    }
}
