//
//  BaseApiClient.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//


import Foundation
import Alamofire
import RxSwift

open class BaseApiClient {
    fileprivate let BASE_URL = "https://80032420-e94c-49d3-8c8b-570639a026cc.mock.pstmn.io/"
    
    /*
     Function for API without headers
     */
    
    
    func generateUrl(route: String) -> String{
        return BASE_URL + route
    }
    
    func requestQpiWithHeaders<T>(
        url : String,
        method : HTTPMethod,
        params : Parameters,
        value : T.Type
        )-> Observable <T> where T: Codable {
        let headers: HTTPHeaders = [:]

        
        
        return Observable<T>.create {(observer) -> Disposable  in
            let request = Alamofire.request(self.BASE_URL + url , method:  method , parameters:  params , headers : headers).responseJSON{response in
                
                switch response.result {
                case .success :
                    if 200...299 ~= response.response?.statusCode ?? 500 {
                        let data = try! JSONDecoder().decode( T.self , from:  response.data!)
                        observer.onNext(data)
                        observer.onCompleted()
                        
                    }else {
                        let error = try! JSONDecoder().decode(ErrorReponse.self, from: response.data!)
                        observer.onError(NSError(domain: error.message ?? "", code: error.code ?? 0 , userInfo: nil))
                    }
                case .failure(let error): observer.onError(error)
                }
                
            }
            return Disposables.create(with : {request.cancel() })
        }
    }
}
