//
//  TableViewCellViewModel.swift
//  OpenWeather
//
//  Created by Илья Першин on 11.02.2021.
//

import Foundation

protocol WeatherTableViewCellViewModelProtocol {
    var iconName: String { get }
    var temperature: String { get }
    var date: String { get }
    var weekDay: String { get }
    init(with dayWeather: DayWeather)
}

class WeatherTableViewModel: WeatherTableViewCellViewModelProtocol {
    var iconName: String {
        ImageService.shared.getSystemIconName(with: dayWeather.hoursWeather.first?.iconName ?? "")
    }
    
    var date: String {
        dayWeather.hoursWeather.first?.date ?? ""
    }
    
    var weekDay: String {
        dayWeather.weekDay ?? ""
    }
    
    var temperature: String {
        dayWeather.hoursWeather.first?.temperature ?? ""
    }
    
    private let dayWeather: DayWeather
        
    required init(with dayWeather: DayWeather) {
        self.dayWeather = dayWeather
    }
}
