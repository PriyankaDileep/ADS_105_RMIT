//
//  WeatherDataModel.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 27/4/21.
//

import Foundation

struct WeatherDataModel: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
