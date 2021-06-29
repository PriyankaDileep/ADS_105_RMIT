//
//  ForecastTableViewController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 30/4/21.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    var location:Location!
    private var forecasts:[Forecast] = ForecastDataController.forecasts
    private enum segueIdentifier {
        static let forecastToCurrentWeatherInformation: String = "forecastToCurrentWeather"
        static let forecastToDailyWeatherInformation: String = "toDailyWeatherForecast"
        static let forecastTo24hrWeatherInformation: String = "to24-hrForecast"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier,segue.destination) {
        case (segueIdentifier.forecastToCurrentWeatherInformation , let destination as CurrentWeatherTableViewController):
            if let indexpath = self.tableView.indexPathForSelectedRow {
                destination.location = location
                destination.forecast = forecasts[indexpath.row]
            }
        case (segueIdentifier.forecastToDailyWeatherInformation, let destination as DailyWeatherTableViewController):
            if let indexpath = self.tableView.indexPathForSelectedRow {
                destination.location = location
                destination.forecast = forecasts[indexpath.row]
            }
            
        case (segueIdentifier.forecastTo24hrWeatherInformation, let destination as HourlyWeatherTableViewController):
            if let indexpath = self.tableView.indexPathForSelectedRow {
                destination.location = location
                destination.forecast = forecasts[indexpath.row]
            }
            
        default:
            break
        }
    }
    
    
}
