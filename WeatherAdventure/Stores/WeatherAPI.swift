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
    
    func fetchCurrentWeather(city: String) -> Observable<Weather> {
        return Observable<Weather>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request(.GET, "http://api.openweathermap.org/data/2.5/weather",
                    parameters: ["q": city, "appid": APIConstants.WeatherAPIKey, "units": UserDefaultsManager.unitsType.rawValue])
                .responseJSON(completionHandler: { (response) in
                    if let value = response.result.value {
                        observer.onNext(Mapper<Weather>().map(value)!)
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
    
    func fetchCurrentForecast(city: String) -> Observable<[Forecast]> {
        return Observable<[Forecast]>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request(.GET, "http://api.openweathermap.org/data/2.5/forecast",
                    parameters: ["q": city, "appid": APIConstants.WeatherAPIKey, "units": UserDefaultsManager.unitsType.rawValue])
                .responseJSON(completionHandler: { (response) in
                    if let value = response.result.value!["list"] {
                        observer.onNext(Mapper<Forecast>().mapArray(value)!)
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
    
    func fetchWeatherIcon(icon: String) -> Observable<NSData> {
        return Observable<NSData>.create({ (observer) -> Disposable in
            let request = Alamofire
                .request(.GET, "http://openweathermap.org/img/w/\(icon).png")
                .responseData(completionHandler: { (response) in
                    if let data = response.data {
                        observer.onNext(data)
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