//
//  TipsVO.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import RealmSwift

class TipsVO : Object ,Codable {
    @objc dynamic var temperature:String = ""
    @objc dynamic var light: String = ""
    @objc dynamic var placement: String = ""
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature"
        case light = "light"
        case placement = "placement"
        
    }
    
}
