//
//  CitiesViewController.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 27/09/21.
//

import UIKit
import CoreLocation

class CitiesViewController: UITableViewController {

    struct Coordinate {
        var lat: Double
        var lon: Double
    }
    
    let viewModel = CitiesViewModel()
    var citie: [Cities]?
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }
    
    func setupBindings() {
        viewModel.getCities { Cities in
            self.citie = Cities
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "weatherSegue" {
            if let weatherViewController = segue.destination as? WeatherViewController {
                
                if let coord = sender as? Coordinate {
                    weatherViewController.lat = coord.lat
                    weatherViewController.lon = coord.lon
                }
                
            }
        }
    }
    
    @IBAction func buttonLocation(_ sender: Any) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
    }
}

extension CitiesViewController {
    
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
        
        if let city = citie {
            if let c = city[indexPath.row].coord {
                let coord = Coordinate(lat: c.lat ?? 0, lon: c.lon ?? 0)
                performSegue(withIdentifier: "weatherSegue", sender: coord)
            }
        }
        
    }

}

extension CitiesViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
          print("LocationManager denied")
            
          let alert = UIAlertController(title: "Location denied", message: "", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          self.present(alert, animated: true)
            
        case .notDetermined:
          print("LocationManager notDetermined")
        case .authorizedWhenInUse:
          locationManager?.requestLocation()
        case .authorizedAlways:
          locationManager?.requestLocation()
        case .restricted:
          print("LocationManager restricted")
        default:
          print("LocationManager didChangeAuthorization")
        }
      }

      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locations.forEach { (location) in
            locationManager?.stopMonitoringSignificantLocationChanges()
            
            let coord = Coordinate(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            performSegue(withIdentifier: "weatherSegue", sender: coord)
        }
        
      }
      
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
           locationManager?.stopMonitoringSignificantLocationChanges()
           return
        }
      }
}
