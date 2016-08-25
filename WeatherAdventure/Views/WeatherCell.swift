//
//  WeatherTableCell.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 18/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    var forecast: Forecast? {
        didSet {
            timeLabel.text = formatTime(forecast!.time!)
            temperatureLabel.text = "\(forecast!.temperature!)°C"
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private func formatTime(value: Double) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.stringFromDate(NSDate(timeIntervalSince1970: value))
    }
}
