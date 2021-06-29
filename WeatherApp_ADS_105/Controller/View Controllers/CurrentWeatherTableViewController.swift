//
//  CurrentWeatherTableViewController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 1/5/21.
//

import UIKit

class CurrentWeatherTableViewController: UITableViewController {
    var location:Location!
    var forecast:Forecast!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    var shadowButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()
        getweatherData()
        styleFavouriteButton()
        updateFavButton()
    }
    
    func getweatherData() {
        createSpinnerView()
        WeatherDataController.shared.getOpenWeatherDataFor(forLatitude: location.latitude, andLongitude: location.longitude) { (result) in
            switch result {
            case .success(let currentWeather):
                self.updateUI(with: currentWeather.current )
            case .failure(let error):
                print(error)
                self.displayError(error,
                                   title: "Failed to Fetch Weather Data")
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
        if (Location.stored() == location && forecastID == 0) {
            UserDefaults.standard.setValue(nil, forKey: "cityName")
            UserDefaults.standard.setValue(nil, forKey: "forecastID")
            shadowButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            animateFavouriteButton(sender: sender)
        } else {
            UserDefaults.standard.setValue(location?.data, forKey: "cityName")
            UserDefaults.standard.setValue(0, forKey: "forecastID")
            shadowButton.setImage(UIImage(systemName: "heart"), for: .normal)
            animateFavouriteButton(sender: sender)
        }
        updateFavButton()
    }
    
    private func updateFavButton() {
        let forecastID = UserDefaults.standard.integer(forKey: "forecastID")
        if (Location.stored() == location
                && forecastID == 0){
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
    
    func updateUI(with currentWeather:CurrentWeatherDataModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(format: "%.0f",currentWeather.temp - 273.15) + "C"
            self.weatherIconImageView.image = UIImage(named: currentWeather.weather[0].icon)
            self.windDirectionLabel.text = "Wind Direction: " + String(currentWeather.windDegree)
            self.windSpeedLabel.text =  "Wind Speed: " + String(currentWeather.windSpeed)
            self.weatherLabel.text = currentWeather.weather[0].main
            print(currentWeather)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return location.name
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.contentView.backgroundColor = UIColor.lightGray
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
