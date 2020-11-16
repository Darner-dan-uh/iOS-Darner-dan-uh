//
//  MypageViewModel.swift
//  Darner-dan-uh
//
//  Created by 문지수 on 2020/11/05.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

class MypageViewModel {

    let disposeBag = DisposeBag()
    let viewModel = MypageViewModel()

    struct Input {
        let userName: Driver<String>
        let userPw: Driver<String>
    }
    struct Output {
        let result: Signal<String>
    }
    func transform(_ input: Input) -> Output {
        let result = PublishSubject<String>()
        
        return Output(result: result.asSignal(onErrorJustReturn: "실패"))
    }
}
