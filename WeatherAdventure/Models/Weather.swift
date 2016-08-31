//
//  Weather.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 13/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {
    
    var locationName: String?
    var iconName: String?
    var temperature: Float?
    var humidity: Float?
    var pressure: Float?
    var windSpeed: Float?
    
    var sunriseValue: Double?
    var sunsetValue: Double?
    
    var description: String? {
        didSet {
            description = capitalizeFirstLetter(description!)
        }
    }
    
    var sunriseTime: String? {
        get {
            return valueToTimeString(sunriseValue!)
        }
    }
    
    var sunsetTime: String? {
        get {
            return valueToTimeString(sunsetValue!)
        }
    }
    
    var temperatureUnit: String! {
        get {
            switch UserDefaultsManager.unitsType {
            case .Metric:
                return "°C"
            case .Imperial:
                return "°F"
            }
        }
    }
    
    var windSpeedUnit: String! {
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
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        locationName <- map["name"]
        iconName <- map["weather.0.icon"]
        temperature <- map["main.temp"]
        description <- map["weather.0.description"]
        humidity <- map["main.humidity"]
        pressure <- map["main.pressure"]
        windSpeed <- map["wind.speed"]
        sunriseValue <- map["sys.sunrise"]
        sunsetValue <- map["sys.sunset"]
    }
    
    private func capitalizeFirstLetter(sentence: String) -> String {
        let startIndex = sentence.startIndex
        let endIndex = sentence.startIndex
        let firstLetter = String(sentence.characters.first! as Character).uppercaseString
        return sentence.stringByReplacingCharactersInRange(startIndex...endIndex, withString: firstLetter)
    }
    
    private func valueToTimeString(value: Double) -> String {
        let date = NSDate(timeIntervalSince1970: value)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.stringFromDate(date)
    }
}