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
    var description: String? {
        didSet {
            description = capitalizeFirstLetter(description!)
        }
    }
    var humidity: Float?
    var pressure: Float?
    var windSpeed: Float?
    var sunrise: Int?
    var sunset: Int?
    
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
        sunrise <- map["sys.sunrise"]
        sunset <- map["sys.sunset"]
    }
    
    private func capitalizeFirstLetter(sentence: String) -> String {
        let startIndex = sentence.startIndex
        let endIndex = sentence.startIndex
        let firstLetter = String(sentence.characters.first! as Character).uppercaseString
        return sentence.stringByReplacingCharactersInRange(startIndex...endIndex, withString: firstLetter)
    }
}