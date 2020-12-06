//
//  MyPageModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/10/15.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

struct MypageModel: Codable {
    
    //let profileImage: String
    let name: String
    let userId: String
    let ModifyProfile: String
    let selectCharacter: String
    
}

struct passwordModel: Codable {
    let password: String?
}
