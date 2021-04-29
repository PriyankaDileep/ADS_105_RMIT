//
//  CurrentWeatherDataModel.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 27/4/21.
//

import Foundation



struct CurrentWeatherDataModel: Codable {
   
    enum codingKeys:String,CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPoint = "dew_point"
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case windGust = "wind_gust"
        case weather
        
    }
    
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Double
    var feelsLike: Double
    var pressure: Int
    var humidity: Int
    var dewPoint: Double
    var uvi: Double
    var clouds: Int
    var visibility: Int
    var windSpeed: Double
    var windDegree: Int
    var windGust: Double?
    var weather: [WeatherDataModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.pressure = try container.decode(Int.self,forKey: .pressure)
        self.humidity = try container.decode(Int.self,forKey: .humidity)
        self.dewPoint = try container.decode(Double.self,forKey: .dewPoint)
        self.uvi = try container.decode(Double.self,forKey: .uvi)
        self.clouds = try container.decode(Int.self,forKey: .clouds)
        self.visibility = try container.decode(Int.self,forKey: .visibility)
        self.windSpeed = try container.decode(Double.self,forKey: .windSpeed)
        self.windDegree = try container.decode(Int.self,forKey: .windDegree)
        self.windGust = try container.decodeIfPresent(Double.self, forKey: .windGust)
        self.weather = try container.decode(Array<WeatherDataModel>.self, forKey: .weather)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        try container.encode(self.dt, forKey:.dt)
        try container.encode(self.sunrise, forKey: .sunrise)
        try container.encode(self.sunset, forKey: .sunset)
        try container.encode(self.temp, forKey: .temp)
        try container.encode(self.feelsLike, forKey: .feelsLike)
        try container.encode(self.pressure, forKey: .pressure)
        try container.encode(self.humidity, forKey: .humidity)
        try container.encode(self.dewPoint, forKey: .dewPoint)
        try container.encode(self.uvi, forKey: .uvi)
        try container.encode(self.clouds, forKey: .clouds)
        try container.encode(self.visibility, forKey: .visibility)
        try container.encode(self.windSpeed, forKey: .windSpeed)
        try container.encode(self.windDegree, forKey: .windDegree)
        if let windGust = self.windGust {
            try container.encode(self.windGust, forKey: .windGust)
        } else {
            try container.encodeNil(forKey: .windGust)
        }
        try container.encode(self.windGust, forKey: .windGust)
        try container.encode(self.weather, forKey: .weather)

    }
}
