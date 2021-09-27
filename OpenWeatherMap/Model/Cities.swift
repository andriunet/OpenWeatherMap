//
//  Cities.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit

// MARK: - Cities
struct Cities : Codable {
    let id: Int?
    let name: String?
    let state: String?
    let country: String?
    let coord: Coord?
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}
