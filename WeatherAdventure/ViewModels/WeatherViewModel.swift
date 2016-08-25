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
    
    private let disposeBag = DisposeBag()
    private let weather: Observable<Weather>
    
    let locationNameObservable: Observable<String>
    let iconObservable: Observable<NSData>
    let temperatureObservable: Observable<String>
    let descriptionObservable: Observable<String>
    let sunriseObservable: Observable<String>
    let sunsetObservable: Observable<String>
    let windSpeedObservable: Observable<String>
    let humidityObservable: Observable<String>
    let pressureObservable: Observable<String>
    
    let weatherVariable = Variable<()>()
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
        
        weather = weatherVariable.asObservable()
            .flatMapLatest({ _ -> Observable<Weather> in
                return weatherAPI.fetchCurrentWeather("Varaždin")
            })
        
        iconObservable = weather
            .flatMap({ weather -> Observable<NSData> in
                return weatherAPI.fetchWeatherIcon(weather.iconName!)
            })
        
        locationNameObservable = weather
            .map({ $0.locationName != nil ? $0.locationName! : "No location provided." })
        
        temperatureObservable = weather
            .map({ $0.temperature != nil ? "\(Int($0.temperature!))°C" : "--" })
        
        descriptionObservable = weather
            .map({ $0.description != nil ? $0.description! : "--" })
        
        sunriseObservable = weather
            .map({ $0.sunriseTime != nil ? $0.sunriseTime! : "--" })
        
        sunsetObservable = weather
            .map({ $0.sunsetTime != nil ? $0.sunsetTime! : "--" })
        
        windSpeedObservable = weather
            .map({ $0.windSpeed != nil ? "\($0.windSpeed!) m/s" : "--" })
        
        humidityObservable = weather
            .map({ $0.humidity != nil ? "\($0.humidity!)%" : "--" })
        
        pressureObservable = weather
            .map({ $0.pressure != nil ? "\($0.pressure!) hPA" : "--" })
    }    
}