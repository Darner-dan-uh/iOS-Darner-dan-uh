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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finishWordTestBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension TestResultViewController {
    private func bindAction() {
        finishWordTestBtn.rx.tap
            .map { var controller = self.navigationController?.viewControllers
                controller?.removeAll()
                self.navigationController?.viewControllers = controller!
                self.navigationController?.popViewController(animated: true)
        }
    }
}
