//
//  ForecastViewController.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 30/09/21.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dailyWeather: [DailyWeather]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let d = dailyWeather { return d.count } else { return 0 }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell", for: indexPath)

        if let d = dailyWeather {
            
            let daily = d[indexPath.row]
            
            cell.textLabel?.text = Date(timeIntervalSince1970: Double(daily.dt)).getMouthDay()
            cell.detailTextLabel?.text =  "\(Int(daily.temp.max))º / \(Int(daily.temp.min))º"
            
            if let weather = daily.weather.first {
                cell.imageView?.image = UIImage(named: weather.icon)
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
