//
//  MemoModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/26.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

class MemoModel: Codable {

    var memo: String = ""
    
    enum memoModelKeys: String, CodingKey{
      case memo
    }
}
