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
    var word: String!
    struct Input {
        let meanSubject: Observable<String>
        let nextWordTap: Single<Void>
    }
    
    struct Output {
        let resultWord: Observable<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        return Output(resultWord: input.meanSubject.map { $0.isEmpty }.asObservable())
            
    }
}
