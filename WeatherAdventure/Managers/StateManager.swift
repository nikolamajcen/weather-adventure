//
//  StateManager.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 31/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import Foundation
import RxSwift

class StateManager {
    
    static let instance = StateManager()
    
    let stateChanged: PublishSubject<Bool>
    
    init() {
        stateChanged = PublishSubject<Bool>()
    }
}