//
//  Model.swift
//  OpenWeather
//
//  Created by Илья Першин on 10.02.2021.
//

import Foundation
import SwiftyJSON

struct WeatherData {
    var fiveDayWeather: FiveDayWeather
    var cityName: String?
    
    init(with json: JSON) {
        let weatherListJSON = json["list"].arrayValue
       
        let cityName = json["city"]["name"].stringValue
        let fiveDayWeather = FiveDayWeather(with: weatherListJSON)
        
        self.cityName = cityName
        self.fiveDayWeather = fiveDayWeather
    }
}

struct FiveDayWeather {
    var daysWeather: [DayWeather]
    
    init(with json: [JSON]) {
        var daysWeather: [DayWeather] = []
        var json = json
        
        let fiveDaysRange = 0...4
        
        for _ in fiveDaysRange {
            let dayWeather = DayWeather(with: &json)
            daysWeather.append(dayWeather)
        }
        
        self.daysWeather = daysWeather
    }
}

struct DayWeather {
    var hoursWeather: [Weather]
    var weekDay: String?
    
    init(with json: inout [JSON]) {
        var hoursWeather: [Weather] = []
        
        let forecastsRange = 0...7
        let lastForecastTime = "21"
        
        for _ in forecastsRange {
            let weatherItemJSON = json.removeFirst()
            let hourWeather = Weather(with: weatherItemJSON)
            
            hoursWeather.append(hourWeather)
            
            if hoursWeather.last?.time == lastForecastTime {
                break
            }
        }
        
        let weekDay = ConvertService.convertDateToWeekDay(with: hoursWeather.last?.date ?? "")
        
        self.hoursWeather = hoursWeather
        self.weekDay = weekDay
    }
}

struct Weather {
    var temperature: String?
    var description: String?
    var iconName: String?
    var date: String?
    var time: String?
    
    init(with json: JSON) {
        let fullDate = json["dt_txt"].stringValue.split(separator: " ")
        let date = ConvertService.formatDate(with: String(fullDate.first ?? ""))
        let time = ConvertService.formatTime(with: String(fullDate.last ?? ""))
        let temperature = ConvertService.convertKelvinToCelsius(kelvin: json["main"]["temp"].doubleValue)
        
        let hourWeatherJSON = json["weather"].arrayValue.first ?? []
        
        let description = hourWeatherJSON["description"].stringValue
        let iconName = hourWeatherJSON["icon"].stringValue
        
        self.temperature = temperature
        self.description = description
        self.iconName = iconName
        self.date = date
        self.time = time
    }
}






