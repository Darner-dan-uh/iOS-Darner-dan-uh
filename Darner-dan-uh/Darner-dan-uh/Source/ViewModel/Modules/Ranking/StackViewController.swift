//
//  StackViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/12/07.
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
       //buttonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    func buttonAction() {
        rankingBtn.rx.tap
            .subscribe{ _ in
                self.nextVC(identifier: "ranking")
            }.disposed(by: disposeBag)
    }
    

 
}

extension UIViewController {
    func navigationClear(){
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    func nextVC(identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(identifier: identifier)
        viewController?.modalPresentationStyle = .fullScreen
        present(viewController!, animated: false, completion: nil)


    }
}
