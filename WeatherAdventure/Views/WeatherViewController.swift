//
//  ViewController.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 13/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var forecastButton: UIButton!
    
    let viewModel = WeatherViewModel(weatherAPI: WeatherAPI())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        initializeUIBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.hideBorderLine()
    }
    
    fileprivate func initializeUI() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    fileprivate func initializeUIBindings() {
        viewModel.weatherVariable.asObservable()
            .subscribe { [unowned self] _ in MBProgressHUD.hide(for: self.view, animated: true) }
            .addDisposableTo(disposeBag)
        
        refreshButton.rx.tap
            .map { [unowned self] in MBProgressHUD.showAdded(to: self.view, animated: true) }
            .bindTo(viewModel.weatherVariable)
            .addDisposableTo(disposeBag)
        
        viewModel.iconObservable
            .map { UIImage.init(data: $0 as Data) }
            .bindTo(weatherImage.rx.image)
            .addDisposableTo(disposeBag)
        
        viewModel.locationNameObservable
            .map { $0 }
            .bindTo(locationNameLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.temperatureObservable
            .map { $0 }
            .bindTo(temperatureLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.descriptionObservable
            .map { $0 }
            .bindTo(descriptionLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.sunriseObservable
            .map { $0 }
            .bindTo(sunriseLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.sunsetObservable
            .map { $0 }
            .bindTo(sunsetLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.windSpeedObservable
            .map { $0 }
            .bindTo(windSpeedLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.humidityObservable
            .map { $0 }
            .bindTo(humidityLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.pressureObservable
            .map { $0 }
            .bindTo(pressureLabel.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.forecastObservable
            .bindTo(forecastButton.rx.enabled)
            .addDisposableTo(disposeBag)
    }
}
