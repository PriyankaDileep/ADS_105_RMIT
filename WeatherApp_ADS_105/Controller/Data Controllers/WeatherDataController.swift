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
    private static var apikeyQueryItem: URLQueryItem {
        URLQueryItem(name: "appid", value: "4168288dde430876e75098e7f4675737")
    }
    
    static let shared: WeatherDataController = WeatherDataController()
    
    
    
//    func getOpenWeatherData() {
//        let session = URLSession.shared
//        var urlComponents:URLComponents! = URLComponents(string:Self.baseURLString)
//        let queryItems:[URLQueryItem] = [Self.apikeyQueryItem,URLQueryItem(name: "lat", value: "-37"),URLQueryItem(name: "lon", value: "144")]
//        urlComponents.queryItems = queryItems
//        if let url = urlComponents.url{
//        let task = session.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                print("Error. Data task completed with an error\(String(describing: error))")
//                return
//            }
//            if let data = data {
//                let decoder = JSONDecoder()
//                do {
//                    let response = try decoder.decode(OneCallResponse.self, from: data)
//                    print(response.current)
//                } catch {
//                    debugPrint(error)
//                }
//            }
//        }
//        task.resume()
//    }
//}
    
    func getOpenWeatherDataFor(forLatitude latitude:String, andLongitude longitude:String, completion:@escaping (Result<OneCallResponse, Error>) -> Void) {
        let session = URLSession.shared
        var urlComponents:URLComponents! = URLComponents(string:Self.baseURLString)
        let queryItems:[URLQueryItem] = [Self.apikeyQueryItem,URLQueryItem(name: "lat", value: latitude),URLQueryItem(name: "lon", value: longitude)]
        urlComponents.queryItems = queryItems
        if let url = urlComponents.url{
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error. Data task completed with an error\(String(describing: error))")
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(OneCallResponse.self, from: data)
                    completion(.success(response))

                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    }
}
