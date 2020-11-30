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
    case register(userId: String, name: String, email: String, password: String)
    case verifywithemail(email: String, code: String)
    case login(userId: String, password: String)
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
        return "http://10.156.145.103:9032" //FIX- 주소 수정
//        return "http://localhost:5000"
    }
    
    var path: String {
        switch self {
        case .register:
            return "/register"
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
             .wordGenre,
             .login:
            return .post
            
        case .logout,
             .rank,
             .stack,
             .wordTest,
             .myProfile,
             .memoTitle,
             .memoContents:
            return .get
            
        case .deleteMemo:
            return .delete
            
        case .updateProfile:
            return .put
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .wordGenre,
             .wordTest:
            let token = UserDefaults.standard.value(forKey: "token") as! String
            return ["Authorization" : "Bearer " + token]
        default:
            return ["Content-Type":"application/json"]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .logout,
             .rank,
             .stack,
             .wordTest,
             .myProfile,
             .memoTitle,
             .memoContents:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .verifywithemail(let email,let code):
            return ["email" : email, "code": code]
            
        case .register(let userId, let name, let email, let password):
            return ["userId" : userId, "name" : name, "email" : email, "password": password]
            
        case .login(let userId, let password):
            return ["userId": userId, "password": password]
            
        case .wordGenre(let word_id, let number):
            return ["word_id": "\(word_id)", "number": "\(number)"]
        default:
            return nil
        }
    }
}
