//
//  WeatherAPI.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 13/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift

class WeatherAPI {
    
    func fetchCurrentWeather(_ city: String) -> Observable<Weather> {
        return Observable<Weather>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request("http://api.openweathermap.org/data/2.5/weather",
                         method: .get,
                         parameters: [
                            "q": city,
                            "appid": APIConstants.WeatherAPIKey,
                            "units": UserDefaultsManager.unitsType.rawValue
                    ]
                )
                .responseJSON(completionHandler: { (response) in
                    if let value = response.result.value {
                        observer.onNext(Mapper<Weather>().map(JSONObject: value)!)
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
    
    func fetchCurrentForecast(_ city: String) -> Observable<[Forecast]> {
        return Observable<[Forecast]>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request("http://api.openweathermap.org/data/2.5/forecast",
                         method: .get,
                         parameters: [
                            "q": city,
                            "appid": APIConstants.WeatherAPIKey,
                            "units": UserDefaultsManager.unitsType.rawValue
                    ]
                )
                .responseJSON(completionHandler: { (response) in
                    if let value = (response.result.value as! [String:AnyObject])["list"] {
                        observer.onNext(Mapper<Forecast>().mapArray(JSONObject: value)!)
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
    
    func fetchWeatherIcon(_ icon: String) -> Observable<NSData> {
        return Observable<NSData>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request("http://openweathermap.org/img/w/\(icon).png", method: .get)
                .responseData(completionHandler: { (response) in
                    if let data = response.data {
                        observer.onNext(data as NSData)
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
