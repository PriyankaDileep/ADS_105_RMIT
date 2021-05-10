//
//  ForecastTableViewController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 30/4/21.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    var location:Location!
    private enum segueIdentifier {
        static let forecastToCurrentWeatherInformation: String = "forecastToCurrentWeather"
        static let forecastToDailyWeatherInformation: String = "toDailyWeatherForecast"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = self.location.name
       
    }

    // MARK: - Table view data source

   
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier,segue.destination) {
        case (segueIdentifier.forecastToCurrentWeatherInformation , let destination as CurrentWeatherTableViewController):
            if let indexpath = self.tableView.indexPathForSelectedRow {
                destination.location = location
            }
        case (segueIdentifier.forecastToDailyWeatherInformation, let destination as DailyWeatherTableViewController):
              destination.location = location
        default:
            break
        }
    }
  

}
