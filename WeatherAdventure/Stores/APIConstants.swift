//
//  APIConstants.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 13/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation

class APIConstants {
    
    static var WeatherAPIKey: String! {
        get {
            return readConfigurationValue("weatherApiKey", file: "API", type: "plist")
        }
    }
    
    static var LocationAPIKey: String! {
        get {
            return readConfigurationValue("locationApiKey", file: "API", type: "plist")
        }
    }
    
    static fileprivate func readConfigurationValue(_ key: String ,file: String, type: String) -> String! {
        if let path = Bundle.main.path(forResource: file, ofType: type) {
            let dictionary = NSDictionary(contentsOfFile: path)
            return dictionary?.value(forKey: key) as! String
        } else {
            return nil
        }
    }
}
