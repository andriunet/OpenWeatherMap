//
//  WeatherViewController.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var lat: Double = 0
    var lon: Double = 0
    
    let viewModel = WeatherViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getWeather(lat: lat, lon: lon, callback: { weatherCity in
            print(weatherCity.name)
        })
        
    }


}

