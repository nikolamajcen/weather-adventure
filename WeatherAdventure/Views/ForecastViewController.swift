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
import RxDataSources
import MBProgressHUD

class ForecastViewController: UIViewController {
    
    @IBOutlet var forecastTableView: UITableView!
    
    let viewModel = ForecastViewModel(weatherAPI: WeatherAPI())
    let disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<DailyForecast>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableDataSource()
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
            .bindTo(forecastTableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
    }
    
    private func configureTableDataSource() {
        dataSource.configureCell = { dataSource, tableView, indexPath, item  in
            let cell = tableView
                .dequeueReusableCellWithIdentifier("ForecastCell", forIndexPath: indexPath) as! ForecastTableViewCell
            cell.forecast = item
            return cell
        }
        
        dataSource.titleForHeaderInSection =  { dataSource, index in
            return dataSource.sectionModels[index].header
        }
    }

}
