//
//  TestCollectionViewCell.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/24.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TestCollectionViewCell: UICollectionViewCell {
    static let cellName = "TestCollectionViewCell"
    var sign: ((String) -> Void)? = nil
    
    @IBOutlet weak var wordMeanTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var wordTestLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func b(_ sender: UIButton) {
        sign?(wordMeanTextField.text!)
    }
}
