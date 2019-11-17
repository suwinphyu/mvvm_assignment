//
//  RealmService.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift
import RxRealm
import RxSwift

class RealmService {
    
    let realm = try! Realm()
    
    static let shared:RealmService = RealmService()
    
    private init(){}
    
    func create<T: Object>(object : T){
        do{
            try realm.write {
                realm.add(object, update: .modified)
            }
        }catch {
            post(error)
        }
    }
    
//    func delete<T : Object>(object : T){
//        do{
//            try realm.write {
//                realm.delete(object)
//            }
//        }catch {
//            post(error)
//        }
//    }
    
    func post(_ error : Error ){
        NotificationCenter.default.post(name: NSNotification.Name("RelamError"), object: error)
    }

    
    func retrieveFavouritePlant() -> Observable<[PlantVO]> {
        return Observable.array(from:realm.objects(PlantVO.self))
    }
    
    func delete(object : PlantVO){
        do{
            let selectedObj = realm.objects(PlantVO.self).filter("plantId = %@", object.plantId)
            try realm.write {
                realm.delete(selectedObj)
            }
        }catch {
            post(error)
        }
    }
}
