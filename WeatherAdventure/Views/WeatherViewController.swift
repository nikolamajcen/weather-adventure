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

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let viewModel = WeatherViewModel(weatherAPI: WeatherAPI())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx_text
            .bindTo(viewModel.nameVariable)
            .addDisposableTo(disposeBag)
        
        viewModel.cityObservable
            .bindTo(cityLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        viewModel.temperatureObservable
            .bindTo(temperatureLabel.rx_text)
            .addDisposableTo(disposeBag)
    }
}