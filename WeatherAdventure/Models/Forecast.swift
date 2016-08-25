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
    
    init() { }
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        time <- map["dt"]
        iconName <- map["weather.0.icon"]
        temperature <- map["main.temp"]
    }
}