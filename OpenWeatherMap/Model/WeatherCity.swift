//
//  WeatherCity.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit

struct WeatherCity : Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Clouds : Codable {
    let all: Int
}

struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
    var sea_level: Int?
    var grnd_level: Int?
}

struct Weather : Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind : Codable {
    let speed: Double
    let deg: Int
}
