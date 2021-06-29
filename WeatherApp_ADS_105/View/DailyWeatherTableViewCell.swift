//
//  DailyWeatherTableViewCell.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 7/5/21.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(item:DailyWeatherDataModel) {
        self.windDirectionLabel.text = "Wind Direction: \(item.windDegree)°"
        self.windSpeedLabel.text = "Wind Speed: \(Double(item.windSpeed.rounded()))km/hr"
        let highTemp = item.temp.max - 273.15
        let lowTemp = item.temp.min - 273.15
        self.highTempLabel.text = "High: \(Int(highTemp.rounded()))°C"
        self.lowTempLabel.text = "Low: \(Int(lowTemp.rounded()))°C"
        let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
        let dayString = Date.getDayOfWeekFrom(date: date)
        self.dateLabel.text = dayString
        for weatherItem in item.weather {
            self.weatherLabel.text = weatherItem.description
            self.weatherImageView.image = UIImage(named: weatherItem.icon)
        }
    }
}
