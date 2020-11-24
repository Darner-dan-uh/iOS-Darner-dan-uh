//
//  TestViewModel.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/24.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class TestViewModel: ViewModelType {
    struct Input {
        let meanSubject: Observable<String>
        let nextWordTap: Single<Void>
    }
    
    struct Output {
        let resultWord: Observable<[WordCell]>
    }
    
    func transform(_ input: Input) -> Output {
        return Output(input.meanSubject.)
    }
}
