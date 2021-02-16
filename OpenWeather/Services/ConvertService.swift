//
//  ConvertService.swift
//  OpenWeather
//
//  Created by Илья Першин on 14.02.2021.
//

import Foundation

class ConvertService {
    static let shared = ConvertService()
    private init() { }
    
    func formatTime(with timeString: String) -> String {
        let time = timeString.split(separator: ":")
        let formatedTime = String(time.first ?? "")
        return formatedTime
    }
    
    func formatDate(with dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formatedDate = dateFormatter.string(from: date)
        
        return formatedDate
    }
    
    func convertDateToWeekDay(with dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        
        return weekDay
    }
    
    func convertKelvinToCelsius(kelvin: Double) -> String {
        String(Int(kelvin - 273.15)) + "°"
    }
}
