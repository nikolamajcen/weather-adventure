//
//  UnitsTableViewController.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit
import RxSwift

class UnitsTableViewController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        showCurrentUnitType()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) where cell.accessoryType != .Checkmark {
            selectUnitType(cell, indexPath: indexPath)
        }
    }
    
    private func showCurrentUnitType() {
        let indexPath: NSIndexPath
        switch UserDefaultsManager.unitsType {
        case .Metric:
            indexPath = NSIndexPath(forRow: 0, inSection: 0)
        case .Imperial:
            indexPath = NSIndexPath(forRow: 1, inSection: 0)
        }
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    private func selectUnitType(cell: UITableViewCell, indexPath: NSIndexPath) {
        removeAllCheckmarks(indexPath)
        cell.accessoryType = .Checkmark
        
        switch indexPath.row {
        case 0:
            UserDefaultsManager.unitsType = .Metric
        case 1:
            UserDefaultsManager.unitsType = .Imperial
        default:
            break
        }
        StateManager.instance.stateChanged.onNext(true)
    }
    
    private func removeAllCheckmarks(indexPath: NSIndexPath) {
        for row in 0...tableView.numberOfRowsInSection(indexPath.section) {
            let currentIndexPath = NSIndexPath(forRow: row, inSection: indexPath.section)
            if let cell = tableView.cellForRowAtIndexPath(currentIndexPath) where cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
            }
        }
    }
}