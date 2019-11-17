//
//  TipsViewModel.swift
//  flowerSchool_MVVM
//
//  Created by Su Win Phyu on 11/16/19.
//  Copyright © 2019 swp. All rights reserved.
//


import Foundation
import RxSwift
import RxRelay


class TipsViewModel : BaseViewModel {
    public var isLoadingObs : BehaviorRelay<Bool> = BehaviorRelay(value: false )
    
    public var _errorObs : BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    
    let apiService = SharedApiClient.shared // to call network call
    public var dataObs : PublishSubject<TipsVO> = PublishSubject()
    
    let bag = DisposeBag()
    override init() {
        
    }
    
    
    public func requestData(){
 
            dataObs
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
            .subscribe(onNext : {response in
                self.isLoadingObs.accept(false)
                self.dataObs.onNext(response)
            }, onError : { error in
                self.isLoadingObs.accept(false)
                self._errorObs.accept(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    
}

