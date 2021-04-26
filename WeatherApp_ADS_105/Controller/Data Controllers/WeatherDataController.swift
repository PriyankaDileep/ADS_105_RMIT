//
//  WeatherDataController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 23/4/21.
//

import Foundation

final class WeatherDataController {
    
    private static let baseURLString: String = "https://api.openweathermap.org/data/2.5/onecall"
    private static var baseURL: URL = URL(string: baseURLString)!
    
    static let shared: WeatherDataController = WeatherDataController()
    
    func getOpenWeatherData() {
        let session = URLSession.shared
        let task = session.dataTask(with: Self.baseURL) { (data, response, error) in
            guard error == nil else {
                print("Error. Data task completed with an error\(String(describing: error))")
                return
            }
            if let data = data {
                print(data)
            }
        }
        task.resume()
    }
}
