//
//  LocationTableViewCell.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    var location: Location! {
        didSet {
            locationNameLabel.text = location.name
        }
    }
}
