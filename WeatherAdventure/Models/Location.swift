//
//  Location.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import ObjectMapper

class Location {
    
    var name: String?
    var latitude: Double?
    var longitude: Double?
    
    required init?(_ map: Map) { }
}

extension Location: Mappable {
    
    func mapping(map: Map) {
        name <- map["results.formatted_address"]
        latitude <- map["results.location.lat"]
        longitude <- map["results.location.lng"]
    }
}