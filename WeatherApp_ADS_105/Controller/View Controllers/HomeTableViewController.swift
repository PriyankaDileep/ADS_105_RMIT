//
//  HomeTableViewController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 22/4/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    private var locations:[Location] = LocationDataController.locations
    
    private enum segueIdentifier {
        static let toForecastInformation:String = "LocationsToForecast"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // WeatherDataController.shared.getOpenWeatherData()
       
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath)

        // Configure the cell...
        let location = self.locations[indexPath.row]
        cell.textLabel?.text = location.name
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
        case (segueIdentifier.toForecastInformation, let destination as ForecastTableViewController):
            if let indexPath = self.tableView.indexPathForSelectedRow{
                destination.location = self.locations[indexPath.row]
            } else {
                print("Location Table view controller , No  selected indexpath")
            }
        default:
            break
        }
    }
    

}
