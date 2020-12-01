//
//  MemoCell.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/26.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    var MemoData: MemoModel! {
        didSet { setUpView() }
    }
    
    private func setUpView() {
        self.titleLbl?.text = MemoData.memo
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
