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
    
    let viewModel = WeatherViewModel(weatherAPI: WeatherAPI())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUIBindings()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.hideBorderLine()
    }
    
    private func initializeUIBindings() {
        refreshButton.rx_tap
            .bindTo(viewModel.weatherVariable)
            .addDisposableTo(disposeBag)
        
        viewModel.iconObservable
            .map(UIImage.init)
            .bindTo(weatherImage.rx_image)
            .addDisposableTo(disposeBag)
        
        viewModel.locationNameObservable
            .bindTo(locationNameLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.temperatureObservable
            .bindTo(temperatureLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.descriptionObservable
            .bindTo(descriptionLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.sunriseObservable
            .bindTo(sunriseLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.sunsetObservable
            .bindTo(sunsetLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.windSpeedObservable
            .bindTo(windSpeedLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.humidityObservable
            .bindTo(humidityLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.pressureObservable
            .bindTo(pressureLabel.rx_text)
            .addDisposableTo(disposeBag)
    }
}