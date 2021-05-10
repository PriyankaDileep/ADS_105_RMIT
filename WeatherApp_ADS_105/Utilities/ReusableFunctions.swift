//
//  ReusableFunctions.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 8/5/21.
//

import Foundation

extension Date {
    
    static func getDayOfWeekFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        var string = dateFormatter.string(from: date)
        if let index = string.lastIndex(of: ",") {
            string = String(string.prefix(upTo: index))
            return string
        }
        return "error"
    }
    
}
