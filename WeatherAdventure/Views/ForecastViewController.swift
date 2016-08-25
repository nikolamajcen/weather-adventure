//
//  ForecastViewController.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 25/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForecastViewController: UIViewController {
    
    @IBOutlet var forecastTableView: UITableView!
    
    let viewModel = ForecastViewModel(weatherAPI: WeatherAPI())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUIBindings()
    }
    
    private func initializeUIBindings() {
        viewModel.forecast
            .bindTo(forecastTableView.rx_itemsWithCellIdentifier("ForecastCell", cellType: ForecastTableViewCell.self))
            { (row, element, cell) in
                cell.forecast = element
            }
            .addDisposableTo(disposeBag)
    }
}
