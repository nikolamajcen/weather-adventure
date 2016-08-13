//
//  WeatherViewModel.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 13/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import RxSwift

class WeatherViewModel {
    
    private let weatherAPI: WeatherAPI
    private let weather: Observable<Weather>
    private let disposeBag = DisposeBag()
    
    let nameVariable = Variable<String>("Zagreb")
    
    let cityObservable: Observable<String>
    let temperatureObservable: Observable<String>
    let descriptionObservable: Observable<String>
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
        
        weather = nameVariable.asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest({ (text) -> Observable<Weather> in
                if text.isEmpty == true {
                    return Observable.just(Weather())
                } else {
                    return weatherAPI.fetchCurrentWeather(text)
                }
            })

        cityObservable = weather.map({ weather in
            if weather.city != nil {
                return weather.city!
            } else {
                return ""
            }
        })
        
        temperatureObservable = weather.map({ weather in
            if weather.temperature != nil {
                return "\(weather.temperature!)°C"
            } else {
                return ""
            }
        })
        
        descriptionObservable = weather.map({ weather in
            if weather.description != nil {
                return weather.description!
            } else {
                return ""
            }
        })
    }
}