//
//  Extension.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 28/09/21.
//

import UIKit

extension Date {

    func getNumberNameDay() -> String {
        let weekdays = [
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat"
        ]
        
        let calendar = Calendar.current.component(.weekday, from: self)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH"
        
        return "\(weekdays[calendar - 1]) \(formatter.string(from: self))"
    }
    
    func getMouthDay() -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "MMMM d"
        
        return "\(formatter.string(from: self))"
    }

}



