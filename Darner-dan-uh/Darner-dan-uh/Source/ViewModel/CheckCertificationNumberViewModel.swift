//
//  CheckCertificationNumberViewModel.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/23.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class CheckCertificationNumberViewModel: ViewModelType {
    struct Input {
        let codeSubject: Observable<String>
    }
    
    struct Output {
        let result: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let bool = input.codeSubject
            .map { !$0.isEmpty }
            .asDriver(onErrorJustReturn: false)
        return Output(result: bool)
    }
}
