//
//  Model.swift
//  OpenWeather
//
//  Created by Илья Першин on 10.02.2021.
//

import Foundation

struct WeatherData {
    var fiveDayWeather: FiveDayWeather?
    var cityName: String?
}

struct FiveDayWeather {
    var daysWeather: [DayWeather]?
}


struct DayWeather {
    var hoursWeather: [Weather]?
}

struct Weather {
    var temperature: Double?
    var description: String?
    var icon: String?
    var date: String?
    var time: String?
}






