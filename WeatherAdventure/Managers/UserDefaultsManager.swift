//
//  UserDefaultsManager.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation

enum UnitType: String {
    case Metric = "metric"
    case Imperial = "imperial"
}


class UserDefaultsManager {
    
    static var location: Location! {
        get {
            let defaults = initializeUserDefaults()
            guard let data = defaults.objectForKey("location") else {
                return nil
            }
            let location = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData) as! Location
            return location
        }
        set {
            let defaults = initializeUserDefaults()
            let data = NSKeyedArchiver.archivedDataWithRootObject(newValue)
            defaults.setObject(data, forKey: "location")
        }
    }
    
    static var unitsType: UnitType {
        get {
            let defaults = initializeUserDefaults()
            guard let unitsType = defaults.stringForKey("unitsType") else {
                return UnitType.Metric
            }
            
            switch unitsType {
            case UnitType.Imperial.rawValue:
                return UnitType.Imperial
            default:
                return UnitType.Metric
            }
        }
        set {
            let defaults = initializeUserDefaults()
            defaults.setValue(newValue.rawValue, forKey: "unitsType")
        }
    }
    
    private static func initializeUserDefaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
}