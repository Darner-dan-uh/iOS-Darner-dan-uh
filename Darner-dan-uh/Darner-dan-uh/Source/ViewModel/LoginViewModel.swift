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

class LoginViewModel {
    let idTextFieldSubject = PublishSubject<String>()
    let pwTextFieldSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        Observable
            .combineLatest(idTextFieldSubject, pwTextFieldSubject)
            .asObservable()
            .map {
                return !$0.isEmpty && !$1.isEmpty
            }
    }
}
