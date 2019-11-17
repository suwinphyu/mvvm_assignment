//
//  SharedApiClient.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import RxSwift

class SharedApiClient: BaseApiClient{
    
    static let shared = SharedApiClient()
    
    private override init() {}
}

extension SharedApiClient: IApiClient{

    
    func checkUserAuthRx(email: String, password: String) -> Observable<UserResponse> {
         return self.requestQpiWithHeaders(url: API_POST_LOGIN + "?email= \(email)&password=\(password)", method: .post, params: [:], value: UserResponse.self)
    }
    
   
    func getAllPlantsListRx() -> Observable<PlantResponse> {
          return self.requestQpiWithHeaders(url: API_POST_GET_ALL_PLANTS, method: .post, params: [:], value: PlantResponse.self)
    }
 
    
}
    
    


