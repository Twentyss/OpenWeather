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
                completion(self.parseJSON(json: json))
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    private func parseJSON(json: JSON)-> WeatherData? {
        var weatherListJSON = json["list"].arrayValue
        let cityName = json["city"]["name"].stringValue

        var daysWeather: [DayWeather] = []
                
        for _ in 0...4 {
            var hoursWeather: [Weather] = []
            
            for _ in 0...7 {
                let weatherListJSONItem = weatherListJSON.removeFirst()
             
                let temperature = weatherListJSONItem["main"]["temp"].doubleValue
               
                let fullDate = weatherListJSONItem["dt_txt"].stringValue.split(separator: " ")
                let date = String(fullDate.first ?? "")
                let time = String(fullDate.last ?? "")
                

                guard let hourWeatherJSON = weatherListJSONItem["weather"].arrayValue.first else { return nil }
                
                let description = hourWeatherJSON["description"].stringValue
                let iconName = hourWeatherJSON["icon"].stringValue
                
                let weather = Weather(temperature: temperature,
                                              description: description,
                                              icon: iconName,
                                              date: date,
                                              time: time)
            
                hoursWeather.append(weather)
                
                if time == "21:00:00" {
                    break
                }
            }
            
            let dayWeather = DayWeather(hoursWeather: hoursWeather)
            daysWeather.append(dayWeather)
        }
        
        let fiveDayWeather = FiveDayWeather(daysWeather: daysWeather)
        let weatherData = WeatherData(fiveDayWeather: fiveDayWeather, cityName: cityName)
       
        return weatherData
    }
}
