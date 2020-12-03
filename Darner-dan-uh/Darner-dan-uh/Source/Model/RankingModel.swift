//
//  RankingModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/20.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation


struct RankingModel: Codable {
    var ranking: Int = -1
    var nickName: String = ""
    var profileImage: String = ""
    
    enum RankingModelKeys: String, CodingKey {
        case ranking
        case nickName
        case profileImage
    }
}

struct myRankingModel: Codable {
    let ranking: Int
    let nickName: String
    let profileImage: String
}
