//
//  DayWeatherTableViewCell.swift
//  WeatherApp_ADS_105
//
//  Created by Priyanka PS on 10/5/21.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(item:DailyWeatherDataModel) {
       // self.dateLabel.text =
        self.windDirectionLabel.text = "Wind Direction: \(item.windDegree)°"
        self.windSpeedLabel.text = "Wind Speed: \(Double(item.windSpeed.rounded()))km/hr"
        //self.highTempLabel.text = String(item.temp.max - 273.15)
            let highTemp = item.temp.max - 273.15
            let lowTemp = item.temp.min - 273.15
        
            self.highTemperatureLabel.text = "High: \(Int(highTemp.rounded()))°C"
            self.lowTemperatureLabel.text = "Low: \(Int(lowTemp.rounded()))°C"
        
       
        
        let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
        let dayString = Date.getDayOfWeekFrom(date: date)
        self.dayLabel.text = dayString
        for weatherItem in item.weather {
            self.weatherConditionLabel.text = weatherItem.description
            self.weatherImageView.image = UIImage(named: weatherItem.icon)
        }
        

    }

}
