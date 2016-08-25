//
//  ForecastTableViewCell.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 25/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var forecast: Forecast! {
        didSet {
            timeLabel.text = formatTime(forecast.time!)
            temperatureLabel.text = "\(forecast.temperature!)°C"
        }
    }
    
    private func formatTime(value: Double) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.stringFromDate(NSDate(timeIntervalSince1970: value))
    }
}
