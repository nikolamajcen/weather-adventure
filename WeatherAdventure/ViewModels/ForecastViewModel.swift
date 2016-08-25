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
    let forecast: Observable<[Forecast]>

    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
        
        forecast = forecastVariable.asObservable()
            .flatMapLatest { _ -> Observable<[Forecast]> in
                return weatherAPI.fetchCurrentForecast("Varazdin")
        }
    }
}