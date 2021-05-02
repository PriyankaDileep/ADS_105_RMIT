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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath)

        // Configure the cell...
        let location = self.locations[indexPath.row]
        cell.textLabel?.text = location.name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
