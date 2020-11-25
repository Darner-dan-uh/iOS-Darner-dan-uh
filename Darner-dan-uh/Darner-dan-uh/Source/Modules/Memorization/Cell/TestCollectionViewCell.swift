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
    
    @IBOutlet weak var wordMeanTextField: UITextField!
    @IBOutlet weak var wordTestLbl: UILabel!
    @IBOutlet weak var nextWordBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
}
