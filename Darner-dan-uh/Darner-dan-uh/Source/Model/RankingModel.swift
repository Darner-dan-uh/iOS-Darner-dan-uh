//
//  RankingModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/20.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation


struct RankingModel: Codable {
    let rank: Int
    let name: String
}

struct Ranking: Codable {
    let ranking: [RankingModel]
}
struct myRankingModel: Codable {
    let rank: Int?
    let message: String?
    let ranking: String?
    
//    enum CodingKeys: String, CodingKey {
//        case rank
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        rank  = try values.decode(String.self, forKey: .rank)
//    }
}

