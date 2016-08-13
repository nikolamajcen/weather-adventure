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
    var description: String? {
        didSet {
            description = capitalizeFirstLetter(description!)
        }
    }
    
    init() { }
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        city <- map["name"]
        temperature <- map["main.temp"]
        description <- map["weather.0.description"]
    }
    
    private func capitalizeFirstLetter(sentence: String) -> String {
        let startIndex = sentence.startIndex
        let endIndex = sentence.startIndex
        let firstLetter = String(sentence.characters.first! as Character).uppercaseString
        return sentence.stringByReplacingCharactersInRange(startIndex...endIndex, withString: firstLetter)
    }
}