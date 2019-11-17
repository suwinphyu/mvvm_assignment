//
//  PlantVO.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//


import Foundation
import RealmSwift

class PlantVO :Object, Codable {
    @objc dynamic var plantId:String = ""
    @objc dynamic var plantName: String = ""
    @objc dynamic var plantPhoto: String = ""
    @objc dynamic var plantDescription: String = ""
    @objc dynamic var tips: TipsVO?
    @objc dynamic var uploadedUser : UploadedUserVO?


    enum CodingKeys: String, CodingKey {
        case plantId = "plant_id"
        case plantName = "plant_name"
        case plantPhoto = "plant_photo"
        case plantDescription = "description"
        case uploadedUser = "uploaded_user"
        case tips = "tips"
        
    }
    
    override static func primaryKey() -> String?{
        return "plantId"
    }
    

}
extension PlantVO {
    static func getPlantById(plantId : String, realm : Realm) -> PlantVO?  {
    return realm.object(ofType: PlantVO.self, forPrimaryKey: plantId)
    }
    
    static func isFavourite(plantId : String, realm : Realm) -> Bool  {
        
        let plant = realm.objects(PlantVO.self).filter("plantId = %@", plantId)
        if (plant.count == 0){return false }
        else {
            return true
        }
        
    }
}




