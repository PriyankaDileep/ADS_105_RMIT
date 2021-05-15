//
//  HourlyWeatherTableViewController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 10/5/21.
//

import UIKit

class HourlyWeatherTableViewController: UITableViewController {
    var location:Location!
    var forecast:Forecast!
    var dailyResultArray: [DailyWeatherDataModel] = []
   
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherDataController.shared.getOpenWeatherDataFor(forLatitude: location.latitude, andLongitude: location.longitude) { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let currentWeather):
                    self.dailyResultArray = currentWeather.daily
                   // print(self.dailyResultArray?.daily as Any)
                   //print(currentWeather)
                    print(self.dailyResultArray[0])
                    updateUI(with: self.dailyResultArray[0])
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func favButtonTapped() {
        let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
        if (Location.stored() == location && forecastID == 1 ){
            UserDefaults.standard.setValue(nil, forKey: "cityName")
            UserDefaults.standard.setValue(nil, forKey: "forecastID")
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        } else {
            UserDefaults.standard.setValue(location?.data, forKey: "cityName")
            UserDefaults.standard.setValue(1, forKey: "forecastID")
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
        updateFavButton()
    }
    
    private func updateFavButton() {
        let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
        if (Location.stored() == location && forecastID == 1 ) {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
    }
    
    func updateUI(with dayWeather:DailyWeatherDataModel){
        DispatchQueue.main.async {
            //self.currentWeather = currentWeather
            self.windDirectionLabel.text = "Wind Direction: \(dayWeather.windDegree)°"
            self.windSpeedLabel.text = "Wind Speed: \(Double(dayWeather.windSpeed.rounded()))km/hr"
            //self.highTempLabel.text = String(item.temp.max - 273.15)
                let highTemp = dayWeather.temp.max - 273.15
                let lowTemp = dayWeather.temp.min - 273.15
            
                self.highTemperatureLabel.text = "High: \(Int(highTemp.rounded()))°C"
                self.lowTemperatureLabel.text = "Low: \(Int(lowTemp.rounded()))°C"
            
           
            
            let date = Date(timeIntervalSince1970: TimeInterval(dayWeather.dt))
            let dayString = Date.getDayOfWeekFrom(date: date)
            self.dayLabel.text = dayString
            for weatherItem in dayWeather.weather {
                self.weatherConditionLabel.text = weatherItem.description
                self.weatherIconImageView.image = UIImage(named: weatherItem.icon)
            }
            
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dayweatherCell", for: indexPath) as! DayWeatherTableViewCell
//
//        // Configure the cell...
//     
//       cell.update(item: self.dailyResultArray[0])
//        return cell
//    }
    

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

}
