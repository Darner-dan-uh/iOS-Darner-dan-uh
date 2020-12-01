//
//  MemoViewModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/26.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class MemoViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    let loadData = PublishRelay<[MemoModel]>()
    
    struct Input {
        let loadData: Signal<Void>
    }
    struct Output {
        let result: Signal<String>
        let loadApplyList: PublishRelay<[MemoModel]>
    }
    
    func transform(_ input: Input) -> Output {
        let result = PublishSubject<String>()
        let loadApplyList = PublishRelay<[MemoModel]>()
        
        return Output(result: result.asSignal(onErrorJustReturn: "실패"), loadApplyList: loadApplyList)
    }
}
