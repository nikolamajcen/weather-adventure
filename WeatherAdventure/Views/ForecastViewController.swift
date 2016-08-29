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
import MBProgressHUD

class ForecastViewController: UIViewController {
    
    @IBOutlet var forecastTableView: UITableView!
    
    let viewModel = ForecastViewModel(weatherAPI: WeatherAPI())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        initializeUIBindings()
    }
    
    private func initializeUI() {
        MBProgressHUD.showHUDAddedTo(view, animated: true)
    }
    
    private func initializeUIBindings() {
        viewModel.forecastVariable.asObservable()
            .subscribe({ (_) in
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            })
            .addDisposableTo(disposeBag)
        
        viewModel.forecast
            .bindTo(forecastTableView.rx_itemsWithCellIdentifier("ForecastCell", cellType: ForecastTableViewCell.self))
            { (row, element, cell) in
                cell.forecast = element
            }
            .addDisposableTo(disposeBag)
    }
}
