//
//  CitiesViewController.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit

class CitiesViewController: UITableViewController {

    let viewModel = CitiesViewModel()
    var citie: [Cities]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getCities { Cities in
            self.citie = Cities
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "weatherSegue" {
            if let weatherViewController = segue.destination as? WeatherViewController {
                
                if let row = sender as? Int {
                    if let city = self.citie {
                        if let coord = city[row].coord {
                            weatherViewController.lat = coord.lat ?? 0
                            weatherViewController.lon = coord.lon ?? 0
                        }
                    }
                }
                
            }
        }
    }

}

extension CitiesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let city = citie { return city.count } else { return 0 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        if let city = citie {
            cell.textLabel?.text = city[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "weatherSegue", sender: indexPath.row)
    }

}
