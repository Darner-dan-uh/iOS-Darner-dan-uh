//
//  SeeMypageViewModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/12/02.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class SeeMypageViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let doneTap: Driver<Void>
    }
    struct Output {
        let result: Signal<String>
    }
    
    func transform(_ input: Input) -> Output {
        let result = PublishSubject<String>()
        
        return Output(result: result.asSignal(onErrorJustReturn: ""))
    }
}
