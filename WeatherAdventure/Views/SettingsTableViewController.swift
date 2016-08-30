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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        initializeUI()
    }
    
    private func initializeUI() {
        locationNameLabel.text = UserDefaultsManager.location.capitalizedString
        unitsTypeLabel.text = UserDefaultsManager.unitsType.rawValue.capitalizedString
    }
}
