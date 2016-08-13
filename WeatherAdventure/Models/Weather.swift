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
    
    var city: String?
    var temperature: Float?
    
    init() { }
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        city <- map["name"]
        temperature <- map["main.temp"]
    }
}