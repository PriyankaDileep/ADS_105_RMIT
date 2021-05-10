//
//  TemperatureDataModel.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 3/5/21.
//

import Foundation

struct TemperatureDataModel:Codable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}
