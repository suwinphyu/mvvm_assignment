//
//  UserViewModel.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/15/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Realm
import RxRealm


class UserViewModel : BaseViewModel {
    public var isLoadingObs : BehaviorRelay<Bool> = BehaviorRelay(value: false )
    public var _errorObs : BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    let apiService = SharedApiClient.shared // to call network call
    public var dataObs : PublishSubject<[UserVO]> = PublishSubject()
    
    let bag = DisposeBag()
    let db = RealmService.shared
    override init() {
        
    }
    
    //to fetch data at launching app
    public func requestData(email: String , password : String) {
        apiService.checkUserAuthRx(email: email, password: password)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
            .subscribe(onNext : { response in
                self.isLoadingObs.accept(false)
                self.dataObs.onNext(response.data)

            }, onError : { error in
                self.isLoadingObs.accept(false)
                self._errorObs.accept(error.localizedDescription)

            }).disposed(by: bag)

    }
    

    

}

