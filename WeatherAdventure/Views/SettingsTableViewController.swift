//
//  SettingsTableViewController.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var unitsTypeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initializeUI()
    }
    
    fileprivate func initializeUI() {
        if let location = UserDefaultsManager.location {
            locationNameLabel.text = location.name
        } else {
            locationNameLabel.text = ""
        }
        unitsTypeLabel.text = UserDefaultsManager.unitsType.rawValue.capitalized
    }
}
