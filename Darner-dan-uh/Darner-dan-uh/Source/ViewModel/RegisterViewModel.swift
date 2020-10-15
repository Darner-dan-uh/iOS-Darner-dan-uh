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

class RegisterViewModel: isValidFuncProtocol {

    let nameTextFieldSubject = PublishSubject<String>()
    let idTextFieldSubject = PublishSubject<String>()
    let pwTextFieldSubject = PublishSubject<String>()
    
    func isvalid() -> Observable<Bool> {
        Observable
            .combineLatest(idTextFieldSubject, pwTextFieldSubject, nameTextFieldSubject)
            .asObservable()
            .map {
                return !$0.isEmpty && !$1.isEmpty && !$2.isEmpty
        }
    }
    
    
}

