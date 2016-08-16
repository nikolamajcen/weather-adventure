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
    private var weather: Observable<Weather>
    private let disposeBag = DisposeBag()
    
    let weatherVariable = Variable<()>()
    
    let locationNameObservable: Observable<String>
    let iconObservable: Observable<UIImage>
    let temperatureObservable: Observable<String>
    let descriptionObservable: Observable<String>
    let sunriseObservable: Observable<String>
    let sunsetObservable: Observable<String>
    let windSpeedObservable: Observable<String>
    let humidityObservable: Observable<String>
    let pressureObservable: Observable<String>
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
        
        weather = weatherVariable.asObservable()
            .flatMapLatest({ (_) -> Observable<Weather> in
                return weatherAPI.fetchCurrentWeather("Varaždin")
            })

        locationNameObservable = weather.map({ weather in
            if weather.locationName != nil {
                return weather.locationName!
            } else {
                return "No location provided."
            }
        })
        
        iconObservable = weather.map({ weather in
            if weather.iconName != nil {
                // TODO
                return UIImage()
            } else {
                return UIImage()
            }
        })
        
        temperatureObservable = weather.map({ weather in
            if weather.temperature != nil {
                return "\(Int(weather.temperature!))°C"
            } else {
                return "--"
            }
        })
        
        descriptionObservable = weather.map({ weather in
            if weather.description != nil {
                return weather.description!
            } else {
                return "--"
            }
        })
        
        sunriseObservable = weather.map({ weather in
            if weather.sunrise != nil {
                return "\(weather.sunrise!)"
            } else {
                return "--"
            }
        })
        
        sunsetObservable = weather.map({ weather in
            if weather.sunset != nil {
                return "\(weather.sunset!)"
            } else {
                return "--"
            }
        })
        
        windSpeedObservable = weather.map({ weather in
            if weather.windSpeed != nil {
                return "\(weather.windSpeed!) m/s"
            } else {
                return "--"
            }
        })
        
        humidityObservable = weather.map({ weather in
            if weather.humidity != nil {
                return "\(weather.humidity!)%"
            } else {
                return "--"
            }
        })
        
        pressureObservable = weather.map({ weather in
            if weather.pressure != nil {
                return "\(weather.pressure!) hPA"
            } else {
                return "--"
            }
        })
    }
}