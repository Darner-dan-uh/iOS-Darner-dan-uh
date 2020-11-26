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
    static var wordType: wordTypeEnum!
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
        Observable.merge(lawBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.law.rawValue) },
                         traditionBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.tradition.rawValue)},
                         artBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.art.rawValue)},
                         harborBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.harbor.rawValue)},
                         agricultureBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.agriculture.rawValue)},
                         militaryBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.military.rawValue)},
                         electricalEnergyBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.electricalEnergy.rawValue)},
                         coalBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum(rawValue: wordTypeEnum.coal.rawValue)}
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

enum wordTypeEnum: String, CaseIterable {
    case law = "법률"
    case tradition = "전통"
    case art = "예술"
    case harbor = "항구"
    case agriculture = "농업"
    case military = "군사"
    case electricalEnergy = "전력"
    case coal = "석탄"
    
    static var asArray: [wordTypeEnum] {return self.allCases}

    func asInt() -> Int {
        return wordTypeEnum.asArray.firstIndex(of: self)!
    }
}

/*
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
     static var wordType: wordTypeEnum!
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
         Observable.merge(lawBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.law.rawValue },
                          traditionBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.tradition.rawValue},
                          artBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.art.rawValue},
                          harborBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.harbor.rawValue},
                          agricultureBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.agriculture.rawValue},
                          militaryBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.military.rawValue},
                          electricalEnergyBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.electricalEnergy.rawValue},
                          coalBtn.rx.tap.map { MemorizationViewController.wordType = wordTypeEnum.coal.rawValue}
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

 enum wordTypeEnum: Int, CaseIterable {
     case law = 1
     case tradition
     case art
     case harbor
     case agriculture
     case military
     case electricalEnergy
     case coal
     
     static var asArray: [wordTypeEnum] { return wordTypeEnum.allCases }
     
     func asInt() -> Int {
         return wordTypeEnum.asArray.firstIndex(of: self)!
     }
     
     var description: String {
         switch self {
         case .law:
             return "법률"
         case .tradition:
             return "전통"
         case .art:
             return "예술"
         case .harbor:
             return "항구"
         case .agriculture:
             return "농업"
         case .military:
             return "군사"
         case .electricalEnergy:
             return "전력"
         case.coal:
             return "석탄"
         }
     }
 }

 enum Directions: String, CaseIterable {
     case north, south, east, west
     
     static var asArray: [Directions] {return self.allCases}
     
     func asInt() -> Int {
         return Directions.asArray.firstIndex(of: self)!
     }
 }

 */
