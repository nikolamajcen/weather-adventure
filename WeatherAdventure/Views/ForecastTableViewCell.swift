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
            temperatureLabel.text = "\(Int(forecast.temperature!))\(forecast.temperatureUnit)"
            setWeatherIcon()
        }
    }
    
    fileprivate func formatTime(_ value: Double) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    fileprivate func setWeatherIcon() {
        DispatchQueue.global(qos: .default).async {
            let url = URL(string: "http://openweathermap.org/img/w/\(self.forecast.iconName!).png")!
            guard let data =  try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async(execute: {
                self.iconImageView.image = UIImage(data: data)
            })
        }
    }
}
