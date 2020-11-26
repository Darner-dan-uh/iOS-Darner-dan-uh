//
//  RankingCell.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/19.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {
    
    @IBOutlet weak var RankingLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    var RankingData: RankingModel! {
        didSet { setUpView() }
    }
    
    private func setUpView() {
        self.RankingLbl?.text = "\(RankingData.ranking)"
        self.profileImage?.image = UIImage(named: RankingData.nickName)
        self.nickNameLbl?.text = RankingData.nickName
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
