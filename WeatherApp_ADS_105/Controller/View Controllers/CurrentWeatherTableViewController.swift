//
//  CurrentWeatherTableViewController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 1/5/21.
//

import UIKit

class CurrentWeatherTableViewController: UITableViewController {
    var location:Location!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherDataController.shared.getOpenWeatherDataFor(forLatitude: location.latitude, andLongitude: location.longitude) { (result) in
            switch result {
            case .success(let currentWeather):
            self.updateUI(with: currentWeather.current )
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI(with currentWeather:CurrentWeatherDataModel){
           DispatchQueue.main.async {
                //self.currentWeather = currentWeather
              self.temperatureLabel.text = String(format: "%.0f",currentWeather.temp - 273.15) + "C"
                self.weatherIconImageView.image = UIImage(named: currentWeather.weather[0].icon)
                self.windDirectionLabel.text = "Wind Direction: " + String(currentWeather.windDegree)
                self.windSpeedLabel.text =  "Wind Speed: " + String(currentWeather.windSpeed)
                self.weatherLabel.text = currentWeather.weather[0].main
                print(currentWeather)
                self.tableView.reloadData()
            }
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return location.name
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        //header.textLabel?.font = UIFont(name: "YourFontname", size: 14.0)
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.contentView.backgroundColor = UIColor.lightGray
    }

}
