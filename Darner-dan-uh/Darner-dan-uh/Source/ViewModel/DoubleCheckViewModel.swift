//
//  DoubleCheckViewModel.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/10/15.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

protocol isValidFuncProtocol {
    func isvalid() -> Observable<Bool>
}

class DoubleCheckViewModel {

    let emailPublishSubject = PublishSubject<String>()
//    
//    func isvalid() -> Observable<Bool> {
//        emailPublishSubject.onNe
//    }
}
