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
    let forecastObservable: Observable<Bool>
    
    let weatherVariable = Variable<()>(())
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
        
        StateManager.instance.stateChanged
            .map { _ in () }
            .bindTo(weatherVariable)
            .addDisposableTo(disposeBag)
 
        weather = weatherVariable.asObservable()
            .flatMapLatest({ _ -> Observable<Weather> in
                if Reachability.isConnectedToNetwork() == true && UserDefaultsManager.location != nil {
                    return weatherAPI.fetchCurrentWeather(UserDefaultsManager.location.name!)
                }
                return Observable.just(Weather())
            })
            .shareReplay(1)
        
        iconObservable = weather
            .flatMap({ weather -> Observable<NSData> in
                if weather.iconName != nil {
                    return weatherAPI.fetchWeatherIcon(weather.iconName!)
                }
                return Observable.just(NSData())
            })
        
        locationNameObservable = weather
            .map ({ _ in UserDefaultsManager.location != nil ? UserDefaultsManager.location.name! : "No location provided." })
        
        temperatureObservable = weather
            .map({ $0.temperature != nil ? "\(Int($0.temperature!))\($0.temperatureUnit)" : "--" })
        
        descriptionObservable = weather
            .map({ $0.description != nil ? $0.description! : "--" })
        
        sunriseObservable = weather
            .map({ $0.sunriseValue != nil ? $0.sunriseTime! : "--" })
        
        sunsetObservable = weather
            .map({ $0.sunsetValue != nil ? $0.sunsetTime! : "--" })
        
        windSpeedObservable = weather
            .map({ $0.windSpeed != nil ? "\($0.windSpeed!) \($0.windSpeedUnit)" : "--" })
        
        humidityObservable = weather
            .map({ $0.humidity != nil ? "\($0.humidity!)%" : "--" })
        
        pressureObservable = weather
            .map({ $0.pressure != nil ? "\($0.pressure!) hPA" : "--" })
        
        forecastObservable = weather
            .map({ $0.temperature != nil ? true : false })
    }
}