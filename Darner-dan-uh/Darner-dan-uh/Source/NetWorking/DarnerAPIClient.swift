//
//  DarnerAPIClient.swift
//  Darner-dan-uh
//
//  Created by 이현욱 on 2020/11/12.
//  Copyright © 2020 이현욱. All rights reserved.
//

import Foundation

import RxSwift
import Alamofire
import RxAlamofire

class DarnerAPIClient {
    static let shared = DarnerAPIClient()
    
    func networkingResult<T: Codable>(from api: DarnerAPI, model: T? = nil) -> Observable<T> {
        return Observable.create { obs in
            let request = AF.request(URL(string: api.baseURL + api.path)!,
                                        method: api.method!,
                                        parameters: api.parameter,
                                        encoding: JSONEncoding.default,
                                        headers: api.header).responseData { response in
                                          //  debugPrint(response)
                                            print(response.response?.statusCode)
                    switch response.result {
                    case .success(let data):
                        do {
                            let dataToUse: T = try JSONDecoder().decode(T.self, from: data)
                            return obs.onNext(dataToUse)
                        } catch(let error) {
                            return obs.onError(error)
                        }
                    case .failure(let error):
                        return obs.onError(error)
                    }
                }
                return Disposables.create {
                    request.cancel()
            }
        }
    }
}
