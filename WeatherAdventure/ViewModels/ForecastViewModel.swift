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
    
    private let weatherAPI: WeatherAPI
    
    private let disposeBag = DisposeBag()
    let forecastVariable = Variable<[Forecast]>([Forecast]())
    let forecast: Observable<[DailyForecast]>
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
        
        forecast = forecastVariable.asObservable()
            .flatMapLatest { _ -> Observable<[Forecast]> in
                return weatherAPI.fetchCurrentForecast("Varazdin")
            }
            .flatMap({ (forecast) -> Observable<[DailyForecast]> in
                let days = Array(Set(forecast.map { $0.getDate() }).sort())
                
                let forecasts = days.map({ (day) in
                    return forecast.filter { (forecast) in
                        return forecast.getDate() == day
                    }
                })
                
                var dailyForecast = [DailyForecast]()
                for index in 0..<days.count {
                    let dayForecast = DailyForecast(header: String(days[index].characters.split(" ")[1]),
                                                    items: forecasts[index])
                    dailyForecast.append(dayForecast)
                }
                return Observable.just(dailyForecast)
            })
    }
}