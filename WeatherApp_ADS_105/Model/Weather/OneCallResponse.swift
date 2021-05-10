//
//  OneCallResponse.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 27/4/21.
//

import Foundation

struct OneCallResponse: Decodable {
    var current: CurrentWeatherDataModel
    var daily: [DailyWeatherDataModel]
}
