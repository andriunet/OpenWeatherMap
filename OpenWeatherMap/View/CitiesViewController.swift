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
        // Do any additional setup after loading the view.
        
        
        viewModel.getCities { Cities in
            self.citie = Cities
            self.tableView.reloadData()
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

}
