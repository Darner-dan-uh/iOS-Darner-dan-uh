//
//  RegisterViewModel.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/14.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class RegisterViewModel: ViewModelType {
    struct Input {
        let nameTextFieldSubject: Observable<String>
        let idTextFieldSubject: Observable<String>
        let pwTextFieldSubject: Observable<String>
        let emailTextFieldSubject: Observable<String>
    }
    struct Output {
        let signal: Driver<Bool>
    }

    func transform(_ input: Input) -> Output {
        let bool = Observable.combineLatest(input.nameTextFieldSubject,
                                            input.idTextFieldSubject,
                                            input.pwTextFieldSubject,
                                            input.emailTextFieldSubject)
            .map { !$0.isEmpty && (!$1.isEmpty && $1.count < 20) && !$3.isEmpty && !$2.isEmpty }
            .asDriver(onErrorJustReturn: false)
        return Output(signal: bool)
    }
}


