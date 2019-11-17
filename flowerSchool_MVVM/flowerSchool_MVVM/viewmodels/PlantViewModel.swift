//
//  PlantViewModel.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//


import Foundation
import RxSwift
import RxRelay
import RxRealm
import Realm


class PlantViewModel : BaseViewModel {
    public var isLoadingObs : BehaviorRelay<Bool> = BehaviorRelay(value: false )
    public var _errorObs : BehaviorRelay<String?> = BehaviorRelay(value: nil)
   
    var favPlantObs :BehaviorRelay<[PlantVO]> = BehaviorRelay(value: [])
    let apiService = SharedApiClient.shared // to call network call
    
    public var dataObs : PublishSubject<[PlantVO]> = PublishSubject()
    public var tipsObs : PublishSubject<[TipsVO]> = PublishSubject()
  

    let db = RealmService.shared
    let bag = DisposeBag()
    override init() {
        
    }
    
    
    public func requestData(){
        apiService.getAllPlantsListRx()
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
            .subscribe(onNext : {response in
                self.isLoadingObs.accept(false)
                self.dataObs.onNext(response.data)
                self.tipsObs.onNext([response.data.first!.tips!])
               // self.tipsObs.accept(response.data.first!.tips)
            }, onError : { error in
                self.isLoadingObs.accept(false)
                self._errorObs.accept(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    public func requestFavourite(){
        db.retrieveFavouritePlant()
            .subscribe(onNext:{ data in
                
                if data.count > 0 {
                    self.isLoadingObs.accept(false)
                    self.favPlantObs.accept(data)
                }
                
            }).disposed(by: bag)
    }

  
  
}
