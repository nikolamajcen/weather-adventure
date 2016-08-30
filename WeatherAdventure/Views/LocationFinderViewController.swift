//
//  LocationFinderViewController.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 30/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LocationFinderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = LocationViewModel(locationAPI: LocationAPI())
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeBindings()
    }
    
    private func initializeBindings() {
        viewModel.locationsObservable
            .bindTo(tableView.rx_itemsWithCellIdentifier("LocationCell", cellType: LocationTableViewCell.self)){ (_, item, cell) in
                cell.location = item
            }
            .addDisposableTo(disposeBag)
        
        searchBar.rx_text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bindTo(viewModel.searchTextVariable)
            .addDisposableTo(disposeBag)
        
        tableView.rx_modelSelected(Location.self)
            .bindTo(viewModel.newLocationVariable)
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected
            .subscribeNext { [unowned self] (indexPath) in
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
                self.navigationController?.popViewControllerAnimated(true)
            }
            .addDisposableTo(disposeBag)
    }
}