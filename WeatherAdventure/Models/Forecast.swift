//
//  Forecast.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 18/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import ObjectMapper

class Forecast: Mappable {
    
    var time: Double?
    var iconName: String?
    var temperature: Float?
    
    var temperatureUnit: String {
        get {
            switch UserDefaultsManager.unitsType {
            case .Metric:
                return "°C"
            case .Imperial:
                return "°F"
            }
        }
    }
    
    var windSpeedUnit: String {
        get {
            switch UserDefaultsManager.unitsType {
            case .Metric:
                return "m/s"
            case .Imperial:
                return "M/h"
            }
        }
    }
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        time <- map["dt"]
        iconName <- map["weather.0.icon"]
        temperature <- map["main.temp"]
    }
    
    func getDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd dd.MM.yyyy."
        let date = Date(timeIntervalSince1970: time!)
        return formatter.string(from: date)
    }
}
