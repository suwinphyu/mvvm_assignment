//
//  UserResponse.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation

class UserResponse: Codable{
    var code: Int = 0
    var message: String = ""
    var data:[UserVO] = []
    
    enum CodingKeys : String,CodingKey{
        case code ,message ,data
    }
}
