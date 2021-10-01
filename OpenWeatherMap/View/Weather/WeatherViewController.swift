//
//  WeatherViewController.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!

    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelVisibility: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var lat: Double = 0
    var lon: Double = 0
    
    let viewModel = WeatherViewModel()
    var forecast: Forecast?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }
    
    func setupBindings() {
    
        viewModel.getWeather(lat: lat, lon: lon, callback: { weatherCity in
            DispatchQueue.main.async {
                self.labelCity.text = weatherCity.name
                self.labelTemp.text = "\(weatherCity.main.temp ?? 0) ºC"

                self.labelWind.text = "\(weatherCity.wind.speed) m/s"
                self.labelPressure.text = "\(weatherCity.main.pressure ?? 0) hPa"
                self.labelHumidity.text = "\(weatherCity.main.humidity ?? 0) %"
                self.labelVisibility.text = "\(weatherCity.visibility / 1000) km" //Se retorna en metros lo convertimos a km

                if let weather = weatherCity.weather.first {
                    self.labelWeather.text =  weather.description
                    self.imageWeather.image = UIImage(named: weather.icon)
                }
            }
        })
        
        viewModel.getForecast(lat: lat, lon: lon) { forecast in
            DispatchQueue.main.async {
                self.forecast = forecast
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.reloadData()
                
                self.performSegue(withIdentifier: "EmbedForecastSegue", sender: nil)
            }
        }
    
    }
    
    @IBAction func buttonClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Prepare
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        if self.forecast == nil {
            return false
        } else {
            return true
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "EmbedForecastSegue" {
            
            if let viewControllerNavigation = segue.destination as? UITabBarController {
                                        
                if let forecastViewController = viewControllerNavigation.children[0] as? ForecastViewController {
                    
                    if let dailyWeather = forecast?.daily {
                        forecastViewController.dailyWeather = dailyWeather
                    }
                }
                
                if let mapViewController = viewControllerNavigation.children[1] as? MapViewController {
                    mapViewController.lon = self.lon
                    mapViewController.lat = self.lat
                }
                
            }
            
        }
        
    }

}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.bounds.height / 2, height: collectionView.bounds.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let f = forecast { return f.hourly.count } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell", for: indexPath) as! HourlyCollectionViewCell
        
        if let f = forecast {
            
            let hourly = f.hourly[indexPath.row]
            
            cell.labelTemp.text = "\(Int(hourly.temp))º"
            cell.labelHour.text = Date(timeIntervalSince1970: Double(hourly.dt)).getNumberNameDay()
            if let weather = hourly.weather.first {
                cell.imageWeather.image = UIImage(named: weather.icon)
            }
        }
        
        return cell
    }
}




