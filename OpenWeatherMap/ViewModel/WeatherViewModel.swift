//
//  WeatherViewModel.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit

class WeatherViewModel {
            
    func getWeather(lat: Double, lon: Double, callback: @escaping (_ weatherCity: WeatherCity) -> ()) {
        
        let url = "\(OpenWeatherMap.baseURL)/weather?lat=\(lat)&lon=\(lon)&units=\(OpenWeatherMap.units)&appid=\(OpenWeatherMap.appid)"

        guard let url = URL(string: url) else{
            return
        }

        URLSession.shared.dataTask(with: url) { (data, res, error) in

            guard let data = data else {
                return
            }

            do {
                let weather = try JSONDecoder().decode(WeatherCity.self, from: data)
                callback(weather)
            } catch {
                print(error)
            }

        }.resume()
        
    }
    
    func getForecast(lat: Double, lon: Double, callback: @escaping (_ forecast: Forecast) -> ()) {
                
        let url = "\(OpenWeatherMap.baseURL)/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&units=\(OpenWeatherMap.units)&appid=\(OpenWeatherMap.appid)"
        
        guard let url = URL(string: url) else{
            return
        }

        URLSession.shared.dataTask(with: url) { (data, res, error) in

            guard let data = data else {
                return
            }

            do {
                let forecast = try JSONDecoder().decode(Forecast.self, from: data)                
                callback(forecast)
            } catch {
                print(error)
            }

        }.resume()
        
    }
    
}
