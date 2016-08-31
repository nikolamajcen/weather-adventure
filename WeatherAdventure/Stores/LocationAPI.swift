//
//  LocationAPI.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift

class LocationAPI {
    
    func fetchLocation(location: String) -> Observable<[Location]> {
        return Observable<[Location]>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request(.GET, "https://maps.googleapis.com/maps/api/geocode/json",
                    parameters: ["address":location, "key":APIConstants.LocationAPIKey])
                .responseJSON(completionHandler: { (response) in
                    if let value = response.result.value {
                        observer.onNext(Mapper<Location>().mapArray(value["results"])!)
                        observer.onCompleted()
                    } else {
                        observer.onError(response.result.error!)
                    }
                })
            return AnonymousDisposable {
                request.cancel()
            }
        })
    }
}