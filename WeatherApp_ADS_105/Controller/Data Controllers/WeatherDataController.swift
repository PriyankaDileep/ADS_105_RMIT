//
//  WeatherDataController.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 23/4/21.
//

import Foundation

final class WeatherDataController {
    
    private static let baseURLString: String = "https://api.openweathermap.org/data/2.5/onecall?appid=dbf4f4951c68322c04cac2b2d7349740&lat=-37&lon=144"
    private static var baseURL: URL = URL(string: baseURLString)!
    private static var apikeyQueryItem: URLQueryItem {
        URLQueryItem(name: "appid", value: "dbf4f4951c68322c04cac2b2d7349740")
    }
    
    static let shared: WeatherDataController = WeatherDataController()
    
    
    
    func getOpenWeatherData() {
        let session = URLSession.shared
        var urlComponents:URLComponents! = URLComponents(string:Self.baseURLString)
        let queryItems:[URLQueryItem] = [Self.apikeyQueryItem,URLQueryItem(name: "lat", value: "-37"),URLQueryItem(name: "lon", value: "144")]
        urlComponents.queryItems = queryItems
        if let url = urlComponents.url{
            let task = session.dataTask(with: Self.baseURL) { (data, response, error) in
                guard error == nil else {
                    print("Error. Data task completed with an error\(String(describing: error))")
                    return
                }
                if let data = data {
                    print(String(data: data, encoding: .utf8))
                }
            }
            task.resume()
        }
        
    }
}
