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
            guard let data = defaults.object(forKey: "location") else {
                return nil
            }
            let location = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Location
            return location
        }
        set {
            let defaults = initializeUserDefaults()
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            defaults.set(data, forKey: "location")
        }
    }
    
    static var unitsType: UnitType {
        get {
            let defaults = initializeUserDefaults()
            guard let unitsType = defaults.string(forKey: "unitsType") else {
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
    
    fileprivate static func initializeUserDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
}
