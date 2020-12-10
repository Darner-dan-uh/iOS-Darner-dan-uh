//
//  MemoModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/12/07.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

class MemoModel: Codable {
    let content: String
    
    
    init(content: String) {
        self.content = content
    }
    
    static var dummyDataList = [
        MemoModel(content: "DarnerDanuh"),
        MemoModel(content: "Daaaarneeeer")
    ]
}
