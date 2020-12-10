//
//  WordModel.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/27.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

struct WordModel: Codable {
    let content: [Content]?
    let message: String?
}

struct Content: Codable {
    let korea, english: String
}