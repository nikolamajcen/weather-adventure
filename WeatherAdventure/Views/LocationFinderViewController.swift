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
    
    fileprivate let viewModel = LocationViewModel(locationAPI: LocationAPI())
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchBar.becomeFirstResponder()
    }
    
    fileprivate func initializeBindings() {
        viewModel.locationsObservable
            .bindTo(tableView.rx.items(cellIdentifier: "LocationCell", cellType: LocationTableViewCell.self))
            { (_, item, cell) in
                cell.location = item
            }
            .addDisposableTo(disposeBag)
        
        searchBar.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bindTo(viewModel.searchTextVariable)
            .addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Location.self)
            .bindTo(viewModel.newLocationVariable)
            .addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
                if let navigationController = self.navigationController {
                    navigationController.popViewController(animated: true)
                }
            })
            .addDisposableTo(disposeBag)
    }
}
