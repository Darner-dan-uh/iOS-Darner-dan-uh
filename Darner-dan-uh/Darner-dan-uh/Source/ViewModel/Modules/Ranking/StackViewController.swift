//
//  StackViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/12/04.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class StackViewController: UIViewController {
    
    @IBOutlet weak var rankingBtn: UIButton!
    @IBOutlet weak var stackBtn: UIButton!
    @IBOutlet weak var stackImage: UIImageView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationClear()
        navigationImage()
        buttonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    func buttonAction() {
        stackBtn.rx.tap
            .subscribe{ _ in
                self.nextView(identifire: "ranking")
            }.disposed(by: disposeBag)
    }
    

 
}
