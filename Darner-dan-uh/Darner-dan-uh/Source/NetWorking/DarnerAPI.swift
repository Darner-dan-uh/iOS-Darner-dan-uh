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
    case rank(_ count: Int)
    case myrank(_ id: String)
    case stack
    case wordGenre(word_id: String, number: String)
    case wordTest
    case myProfile
    case updateProfile(changeId: String)
    case verifyPassword(pw: String)
    case getLevel
    case memoTitle
    case memoContents
    case deleteMemo
    case savedata(id: String, count: Int)
}

extension DarnerAPI {
    var baseURL: String {
        return "http://10.156.145.103:9032"
    }
    
    var path: String {
        switch self {
        case .getLevel:
            return "/user/level"
        case .savedata:
            return "/word/savedata"
        case .register:
            return "/register"
        case .verifywithemail:
            return "/verifywithemail"
        case .login:
            return "/login"
        case.logout:
            return "/logout"
        case .rank(let count):
            return "/rank?count=\(count)"
        case .myrank(let id):
            return "/myrank?id=\(id)"
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
        case .verifyPassword:
            return "/user/verifyPassword"
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
             .login,
             .verifyPassword,
             .wordGenre,
             .savedata,
             .login:
            return .post
            
        case .logout,
             .rank,
             .myrank,
             .stack,
             .wordTest,
             .myProfile,
             .memoTitle,
             .getLevel,
             .memoContents:
            return .get
            
        case .deleteMemo:
            return .delete
            
        case .updateProfile:
            return .patch
        
        default:
            return nil 
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .verifywithemail(_, let code):
            return ["code" : code]
        case .verifyPassword:
            return ["Authorization": "Bearer " + "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJzbWtpbSIsImlhdCI6MTYwNzI2MjAzMSwiZXhwIjoxNjA3MjgwMDMxfQ.mlzlDztiWAWUwDXW_7DUN3SA1FRU9khqOcTqfh4lhP5xJV9PxNeLsuU7bdBYjQOQbsAiETzR020Z-44lp8JjIw",
                    "content-type": "application/json"]
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
        case .updateProfile(let changeId):
            return ["name": changeId]
            
        case .verifywithemail(let email,let code):
            return ["email" : email, "code": code]
            
        case .register(let userId, let name, let email, let password):
            return ["userId" : userId, "name" : name, "email" : email, "password": password]
            
        case .login(let userId, let password):
            return ["userId": userId, "password": password]
            
        case .wordGenre(let word_id, let number):
            return ["word_id": word_id, "number": number]
            
        case .verifyPassword(let pw):
            return ["password": pw]
            
        default:
            return nil
        }
    }
}
