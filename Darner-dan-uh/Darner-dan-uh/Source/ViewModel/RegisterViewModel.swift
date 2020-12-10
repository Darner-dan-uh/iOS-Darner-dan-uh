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
        var idTextFieldSubject: Observable<String>
        var pwTextFieldSubject: Observable<String>
        var emailTextFieldSubject: Observable<String>
        var nameTextField: Observable<String>
    }
    
    struct Output {
        var signal: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let bool = Observable.combineLatest(input.idTextFieldSubject, input.emailTextFieldSubject, input.nameTextField, input.pwTextFieldSubject).map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty && !$3.isEmpty }.asDriver(onErrorJustReturn: false)
        
        return Output(signal: bool)
    }
}

