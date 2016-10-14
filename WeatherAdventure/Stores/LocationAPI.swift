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
    
    func fetchLocation(_ location: String) -> Observable<[Location]> {
        return Observable<[Location]>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request("https://maps.googleapis.com/maps/api/geocode/json",
                         method: .get,
                         parameters: [
                            "address":location,
                            "key":APIConstants.LocationAPIKey
                    ]
                )
                .responseJSON(completionHandler: { (response) in
                    if let value = response.result.value {
                        let json = (value as! [String: AnyObject])["results"]
                        observer.onNext(Mapper<Location>().mapArray(JSONObject: json)!)
                        observer.onCompleted()
                    } else {
                        observer.onError(response.result.error!)
                    }
                })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
