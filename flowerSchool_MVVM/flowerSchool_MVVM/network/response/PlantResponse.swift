//
//  PlantResponse.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation

class PlantResponse: Codable{
    var code: Int = 0
    var message: String = ""
    var data:[PlantVO] = []
    
    enum CodingKeys : String,CodingKey{
        case code ,message ,data
    }
}
