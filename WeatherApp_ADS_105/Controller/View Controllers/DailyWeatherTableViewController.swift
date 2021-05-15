//
//  DailyWeatherTableViewController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 3/5/21.
//

import UIKit

class DailyWeatherTableViewController: UITableViewController {
    var location:Location!
    var forecast:Forecast!
    var dailyResultArray: [DailyWeatherDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherDataController.shared.getOpenWeatherDataFor(forLatitude: location.latitude, andLongitude: location.longitude) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currentWeather):
                    self.dailyResultArray = currentWeather.daily
                   // print(self.dailyResultArray?.daily as Any)
                   //print(currentWeather)
                    print(self.dailyResultArray)
                    self.tableView.reloadData()
                //self.updateUI(with: currentWeather.current )
                case .failure(let error):
                    print(error)
                }
            }
           
        }
        let favButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favButtonTapped))
        navigationItem.rightBarButtonItem = favButton
        updateFavButton()
    }
    
    @objc func favButtonTapped() {
        let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
        if (Location.stored() == location && forecastID == 2) {
            UserDefaults.standard.setValue(nil, forKey: "cityName")
            UserDefaults.standard.setValue(nil, forKey: "forecastID")
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        } else {
            UserDefaults.standard.setValue(location?.data, forKey: "cityName")
            UserDefaults.standard.setValue(2, forKey: "forecastID")
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
        updateFavButton()
    }
    
    private func updateFavButton() {
        let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
        if (Location.stored() == location && forecastID == 2) {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.dailyResultArray.count)
        return self.dailyResultArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyWeatherCell", for: indexPath) as! DailyWeatherTableViewCell

        // Configure the cell...
        
        cell.update(item: self.dailyResultArray[indexPath.row])
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
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return location.name
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.contentView.backgroundColor = UIColor.lightGray
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
