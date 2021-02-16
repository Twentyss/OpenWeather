//
//  NetworkFetcher.swift
//  OpenWeather
//
//  Created by Илья Першин on 11.02.2021.
//

import Foundation
import SwiftyJSON

class NetworkFetcher {
    static let shared = NetworkFetcher()
    
    private init() {}
    
    func fetchWeatherData(completion: @escaping (WeatherData?) -> Void) {
        NetworkService.shared.fetchWeatherJSONData { (data) in
            guard let data = data else { return }
            do {
                let json = try JSON(data: data)
                completion(self.parseToWeatherData(json: json))
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }

    private func parseToWeatherData(json: JSON) -> WeatherData {
        let weatherListJSON = json["list"].arrayValue
       
        let cityName = json["city"]["name"].stringValue
        let fiveDayWeather = parseToFiveDayWeather(json: weatherListJSON)
        
        let weatherData = WeatherData(fiveDayWeather: fiveDayWeather, cityName: cityName)
        
        return weatherData
    }
    

    private func parseToFiveDayWeather(json: [JSON]) -> FiveDayWeather {
        var daysWeather: [DayWeather] = []
        var json = json
        
        for _ in 0...4 {
            let dayWeather = parseToDayWeather(json: &json)
            daysWeather.append(dayWeather)
        }
        
        let fiveDayWeather = FiveDayWeather(daysWeather: daysWeather)
        
        return fiveDayWeather
    }
    
    private func parseToDayWeather(json: inout [JSON]) -> DayWeather {
        var hoursWeather: [Weather] = []
        
        for _ in 0...7 {
            let weatherItemJSON = json.removeFirst()
            let hourWeather = parseToWeather(json: weatherItemJSON)
            hoursWeather.append(hourWeather)
            
            if hoursWeather.last?.time == "21" {
                break
            }
        }
        
        let weekDay = ConvertService.shared.convertDateToWeekDay(with: hoursWeather.last?.date ?? "")
        
        let dayWeather = DayWeather(hoursWeather: hoursWeather, weekDay: weekDay)
        
        return dayWeather
    }
    
    private func parseToWeather(json: JSON) -> Weather {
        let fullDate = json["dt_txt"].stringValue.split(separator: " ")
        let date = ConvertService.shared.formatDate(with: String(fullDate.first ?? ""))
        let time = ConvertService.shared.formatTime(with: String(fullDate.last ?? ""))
        let temperature = ConvertService.shared.convertKelvinToCelsius(kelvin: json["main"]["temp"].doubleValue)
        
        let hourWeatherJSON = json["weather"].arrayValue.first ?? []
        
        let description = hourWeatherJSON["description"].stringValue
        let iconName = hourWeatherJSON["icon"].stringValue
                
        let weather = Weather(temperature: temperature, description: description, iconName: iconName, date: date, time: time)
        
        return weather
    }
    
}
