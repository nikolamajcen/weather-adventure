//
//  ForecastViewModel.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 25/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import RxSwift

class ForecastViewModel {
    
    fileprivate let weatherAPI: WeatherAPI
    
    fileprivate let disposeBag = DisposeBag()
    let forecastVariable = Variable<[Forecast]>([Forecast]())
    let forecast: Observable<[DailyForecast]>
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
        
        forecast = forecastVariable.asObservable()
            .flatMapLatest { _ -> Observable<[Forecast]> in
                if Reachability.isConnectedToNetwork() == true {
                    return weatherAPI.fetchCurrentForecast(UserDefaultsManager.location.name!)
                }
                return Observable.just([Forecast]())
            }
            .flatMap({ (forecast) -> Observable<[DailyForecast]> in
                let days = Array(Set(forecast.map { $0.getDate() }).sorted())
                
                let forecasts = days.map({ (day) in
                    return forecast.filter { (forecast) in
                        return forecast.getDate() == day
                    }
                })
                
                var dailyForecast = [DailyForecast]()
                for index in 0..<days.count {
                    let date = String((days[index] as String).characters.split(separator: " ")[1])
                    let dayForecast = DailyForecast(header: date, items: forecasts[index])
                    dailyForecast.append(dayForecast)
                }
                return Observable.just(dailyForecast)
            })
    }
}
