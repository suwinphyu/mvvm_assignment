//
//  IApiClient.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//


import Foundation
import RxSwift

protocol IApiClient {
    
   func checkUserAuthRx(email: String , password : String) -> Observable<UserResponse>
    
   func getAllPlantsListRx() -> Observable<PlantResponse>
    

    
  
    
}

