//
//  CitiesViewModel.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit

class CitiesViewModel {
    
    
    func getCities(callback: @escaping (_ cities: [Cities]) -> ()) {
        
        let decoder = JSONDecoder()
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let cities = try decoder.decode([Cities].self, from: data)

                  callback(cities)
                
              } catch {
                   print(error)
              }
        } else {
            print("File not found")
        }
        
    }
    
}




