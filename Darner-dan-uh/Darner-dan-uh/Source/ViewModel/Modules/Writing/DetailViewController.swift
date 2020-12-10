//
//  DetailViewController.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/12/10.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var txtView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtView.layer.borderColor = UIColor.customGray.cgColor
        txtView.layer.borderWidth = 1.5
        txtView.layer.cornerRadius = 20
    }
    


}
