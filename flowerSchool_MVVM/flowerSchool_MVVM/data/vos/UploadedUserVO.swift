//
//  UploadedUserVO.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import RealmSwift

class UploadedUserVO : Object, Codable {
    @objc dynamic var name:String = ""
    @objc dynamic var userPhoto: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case userPhoto = "user_photo"
        
    }
}

