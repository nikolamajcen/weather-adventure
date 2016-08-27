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
            temperatureLabel.text = "\(Int(forecast.temperature!))°C"
            setWeatherIcon()
        }
    }
    
    private func formatTime(value: Double) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.stringFromDate(NSDate(timeIntervalSince1970: value))
    }
    
    private func setWeatherIcon() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let url = NSURL(string: "http://openweathermap.org/img/w/\(self.forecast.iconName!).png")!
            guard let data =  NSData(contentsOfURL: url) else { return }
            dispatch_async(dispatch_get_main_queue(), {
                self.iconImageView.image = UIImage(data: data)
            })
        }
    }
}