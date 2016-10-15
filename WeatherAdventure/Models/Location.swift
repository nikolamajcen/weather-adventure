//
//  Location.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: NSObject, NSCoding {
    
    var name: String?
    var latitude: Float?
    var longitude: Float?
    
    override init() { }
    
    init(name: String, latitude: Float, longitude: Float) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let latitude = aDecoder.decodeFloat(forKey: "latitude")
        let longitude = aDecoder.decodeFloat(forKey: "longitude")
        self.init(name: name, latitude: latitude, longitude: longitude)
    }
    
    required init?(map: Map) { }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(latitude!, forKey: "latitude")
        aCoder.encode(longitude!, forKey: "longitude")
    }
}

extension Location: Mappable {
    
    func mapping(map: Map) {
        name <- map["formatted_address"]
        latitude <- map["geometry.location.lat"]
        longitude <- map["geometry.location.lng"]
    }
}
