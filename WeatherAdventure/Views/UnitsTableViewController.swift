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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showCurrentUnitType()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) , cell.accessoryType != .checkmark {
            selectUnitType(cell, indexPath: indexPath)
        }
    }
    
    fileprivate func showCurrentUnitType() {
        let indexPath: IndexPath
        switch UserDefaultsManager.unitsType {
        case .Metric:
            indexPath = IndexPath(row: 0, section: 0)
        case .Imperial:
            indexPath = IndexPath(row: 1, section: 0)
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    fileprivate func selectUnitType(_ cell: UITableViewCell, indexPath: IndexPath) {
        removeAllCheckmarks(indexPath)
        cell.accessoryType = .checkmark
        
        switch (indexPath as NSIndexPath).row {
        case 0:
            UserDefaultsManager.unitsType = .Metric
        case 1:
            UserDefaultsManager.unitsType = .Imperial
        default:
            break
        }
        StateManager.instance.stateChanged.onNext(true)
    }
    
    fileprivate func removeAllCheckmarks(_ indexPath: IndexPath) {
        for row in 0...tableView.numberOfRows(inSection: (indexPath as NSIndexPath).section) {
            let currentIndexPath = IndexPath(row: row, section: (indexPath as NSIndexPath).section)
            if let cell = tableView.cellForRow(at: currentIndexPath) , cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            }
        }
    }
}
