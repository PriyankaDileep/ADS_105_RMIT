//
//  HourlyWeatherDataModel.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 2/5/21.
//

import Foundation

struct DailyWeatherDataModel: Codable {
    
    enum codingKeys:String,CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
       // case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        //case visibility
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
    
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: TemperatureDataModel
    //var feelsLike: Double
    var pressure: Int
    var humidity: Int
    var dewPoint: Double
    var uvi: Double
    var clouds: Int
   // var visibility: Int
    var windSpeed: Double
    var windDegree: Int
    var windGust: Double?
    var weather: [WeatherDataModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
        self.temp = try container.decode(TemperatureDataModel.self, forKey: .temp)
      //  self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.pressure = try container.decode(Int.self,forKey: .pressure)
        self.humidity = try container.decode(Int.self,forKey: .humidity)
        self.dewPoint = try container.decode(Double.self,forKey: .dewPoint)
        self.uvi = try container.decode(Double.self,forKey: .uvi)
        self.clouds = try container.decode(Int.self,forKey: .clouds)
       // self.visibility = try container.decode(Int.self,forKey: .visibility)
        self.windSpeed = try container.decode(Double.self,forKey: .windSpeed)
        self.windDegree = try container.decode(Int.self,forKey: .windDegree)
        self.windGust = try container.decodeIfPresent(Double.self, forKey: .windGust)
        self.weather = try container.decode(Array<WeatherDataModel>.self, forKey: .weather)
    }
    
}
