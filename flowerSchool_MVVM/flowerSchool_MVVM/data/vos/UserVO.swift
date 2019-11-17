//
//  UserVO.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import RealmSwift

class UserVO : Object , Codable {
    
    @objc dynamic var userId : String = ""
    @objc dynamic var userName : String = ""
    @objc dynamic var userPhotoUrl : String = ""
    @objc dynamic var memberSince :String = ""
    @objc dynamic var memberRank : String = ""
    
    enum CodingKeys : String,CodingKey{
        case userId = "user_id"
        case userName = "user_name"
        case userPhotoUrl = "user_photo_url"
        case memberSince = "member_since"
        case memberRank = "member_rank"
    }
    override static func primaryKey() -> String?{
        return "userId"
    }
    
}



