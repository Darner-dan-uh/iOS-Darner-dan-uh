//
//  LoginViewModel.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/14.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    let disposeBag = DisposeBag()

    struct Input {
        let idTextFieldSubject: Observable<String>
        let pwTextFieldSubject: Observable<String>
    }
    
    struct Output {
        let result: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let bool = Observable.combineLatest(input.idTextFieldSubject, input.pwTextFieldSubject).map { !$0.isEmpty && !$1.isEmpty }.asDriver(onErrorJustReturn: false)
        return Output(result: bool)
    }
}

