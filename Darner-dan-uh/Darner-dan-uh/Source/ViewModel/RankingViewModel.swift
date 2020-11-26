//
//  RankingViewModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/19.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class RankingViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    let loadData = PublishRelay<RankingModel>()

    struct Input {
        let loadData: Signal<Void>
    }
    struct Output {
        let result: Signal<String>
        let loadApplyList: PublishRelay<[RankingModel]>
    }
    
    func transform(_ input: Input) -> Output {
        let result = PublishSubject<String>()
        let loadApplyList = PublishRelay<[RankingModel]>()

        
        return Output(result: result.asSignal(onErrorJustReturn: "메시지 메시지"), loadApplyList: loadApplyList)
    }
}
