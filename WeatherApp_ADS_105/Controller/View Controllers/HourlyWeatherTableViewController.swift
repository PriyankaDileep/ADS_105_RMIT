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
    
    var shadowButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
        styleFavouriteButton()
        updateFavButton()
    }
    
    func getWeatherData() {
        createSpinnerView()
        WeatherDataController.shared.getOpenWeatherDataFor(forLatitude: location.latitude, andLongitude: location.longitude) { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let currentWeather):
                    self.dailyResultArray = currentWeather.daily
                    print(self.dailyResultArray[0])
                    updateUI(with: self.dailyResultArray[0])
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                    self.displayError(error,
                                       title: "Failed to Fetch Weather Data")
                }
            }
        }
    }
    
    func styleFavouriteButton() {
        shadowButton.setImage(UIImage(systemName: "heart"), for: .normal)
        let favButton: UIBarButtonItem = UIBarButtonItem(customView: shadowButton)
        shadowButton.addTarget(self, action: #selector(favButtonTapped(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = favButton
    }
    
    @objc func favButtonTapped(sender: UIButton) {
        let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
        if (Location.stored() == location && forecastID == 1 ){
            UserDefaults.standard.setValue(nil, forKey: "cityName")
            UserDefaults.standard.setValue(nil, forKey: "forecastID")
            shadowButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            animateFavouriteButton(sender: sender)
        } else {
            UserDefaults.standard.setValue(location?.data, forKey: "cityName")
            UserDefaults.standard.setValue(1, forKey: "forecastID")
            
            shadowButton.setImage(UIImage(systemName: "heart"), for: .normal)
            animateFavouriteButton(sender: sender)
        }
        updateFavButton()
    }
    
    private func updateFavButton() {
        let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
        if (Location.stored() == location && forecastID == 1 ) {
            shadowButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            shadowButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func animateFavouriteButton(sender:UIButton) {
        let customview = sender
        UIView.animate(withDuration: 1.0, animations: {
            let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            customview.transform = scaleTransform
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: {
                customview.transform = CGAffineTransform.identity
            })
        }
    }
    
    func updateUI(with dayWeather:DailyWeatherDataModel){
        DispatchQueue.main.async {
            self.windDirectionLabel.text = "Wind Direction: \(dayWeather.windDegree)°"
            self.windSpeedLabel.text = "Wind Speed: \(Double(dayWeather.windSpeed.rounded()))km/hr"
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
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title,
                   message: error.localizedDescription,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss",
                   style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
