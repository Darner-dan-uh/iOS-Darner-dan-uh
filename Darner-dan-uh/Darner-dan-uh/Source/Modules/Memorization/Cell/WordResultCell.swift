//
//  WordResultCell.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/03.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class WordResultCell: UITableViewCell {
    static let cellName = "WordResultCell"

    @IBOutlet weak var wordMeanLbl: UILabel!
    @IBOutlet weak var isCorrectLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
