//
//  CharacterCollectionViewCell.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/12/10.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    static let cellName = "CharacterCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}
