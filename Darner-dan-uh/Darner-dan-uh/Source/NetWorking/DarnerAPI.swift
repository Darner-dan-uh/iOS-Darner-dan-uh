//
//  DarnerAPI.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/02.
//  Copyright © 2020 이현욱. All rights reserved.
//

import UIKit

import Alamofire
import RxAlamofire

enum DarnerAPI {
    case register
    case verifywithemail
    case login
    case logout
    case rank
    case stack
    case wordGenre(word_id: String, number: String)
    case wordTest
    case myProfile
    case updateProfile
    case memoTitle
    case memoContents
    case deleteMemo
}

extension DarnerAPI {
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .register:
            return "/signup"
        case .verifywithemail:
            return "/verifywithemail"
        case .login:
            return "/login"
        case.logout:
            return "/logout"
        case .rank:
            return "/rank"
        case .stack:
            return "/stack"
        case .wordGenre:
            return "/word/genre"
        case .wordTest:
            return "/word/test"
        case .myProfile:
            return "/user/profile"
        case .updateProfile:
            return "/user/update"
        case .memoTitle:
            return "/memo/title"
        case .memoContents:
            return "memo/title/contents"
        case .deleteMemo:
            return "memo/delete"
        }
    }
    
    var method: HTTPMethod? {
        switch self {
        case .register,
             .verifywithemail,
             .login:
            return .post
        case .logout,
             .rank,
             .stack,
             .wordGenre,
             .wordTest,
             .myProfile,
             .memoTitle,
             .memoContents:
            return .get
            
        case .deleteMemo:
            return .delete
            
//        case .updateProfile:
//            return .update
        default:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .verifywithemail:
            return ["":""]
        default:
            return nil
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .verifywithemail:
            return ["":""]
        default:
            return nil
        }
    }
}
