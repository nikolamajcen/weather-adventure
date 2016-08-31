//
//  LocationViewModel.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import RxSwift

class LocationViewModel {
    
    private let locationAPI: LocationAPI
    
    private let disposeBag = DisposeBag()
    
    let locationsObservable: Observable<[Location]>
    let searchTextVariable = Variable<String>("")
    let newLocationVariable = Variable<Location>(Location())
    
    init(locationAPI: LocationAPI) {
        self.locationAPI = locationAPI
        
        locationsObservable = searchTextVariable.asObservable()
            .flatMapLatest({ name -> Observable<[Location]> in
                if Reachability.isConnectedToNetwork() == true {
                    return locationAPI.fetchLocation(name)
                }
                return Observable.just([Location]())
            })
        
        newLocationVariable.asObservable()
            .filter { $0.name != nil }
            .subscribeNext { location in
                UserDefaultsManager.location = location
                StateManager.instance.stateChanged.onNext(true)
            }
            .addDisposableTo(disposeBag)
    }
}