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

class RegisterViewModel {
    let nameTextFieldSubject = PublishSubject<String>()
    let idTextFieldSubject = PublishSubject<String>()
    let pwTextFieldSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        Observable
            .combineLatest(idTextFieldSubject, pwTextFieldSubject, nameTextFieldSubject)
            .asObservable()
            .map { 
                return !$0.isEmpty && !$1.isEmpty && !$2.isEmpty
        }
    }
    
    func a(str: String) -> Observable<Bool> {
        return str.isEmpty
    }
    
}
