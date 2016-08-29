//
//  DailyForecast.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 29/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import RxDataSources

typealias Item = Forecast

struct DailyForecast {
    
    var header: String
    var items: [Item]
}

extension DailyForecast: SectionModelType {
    
    init(original: DailyForecast, items: [Item]) {
        self = original
        self.items = items
    }
}