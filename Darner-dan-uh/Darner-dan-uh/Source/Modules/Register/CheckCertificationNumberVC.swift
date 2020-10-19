//
//  CheckCertificationNumberVC.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/19.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

final class CheckCertificationNumberVC: UIViewController {
    
    @IBOutlet weak var certificationNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
    }

    @IBAction func popVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtn(_ sender: UIButton) {
    }
}

extension CheckCertificationNumberVC {
    func bindUI() {
        
    }
}
