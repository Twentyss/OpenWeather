//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Илья Першин on 10.02.2021.
//

import Foundation

protocol WeatherViewModelProtocol: class {
    var imageData: Data? { get }
    var weatherData: WeatherData? { get }
    
    func fetchWeatherData(completion: @escaping() -> Void)
    func numberOfTableViewRows() -> Int
    func numberOfCollectionViewRows() -> Int 
}

class WeatherViewModel: WeatherViewModelProtocol {
    var weatherData: WeatherData?
    
    var imageData: Data? {
        nil // Will return image data 
    }
    
    var viewModelDidChange: ((WeatherViewModelProtocol) -> Void)?
    
    func fetchWeatherData(completion: @escaping () -> Void) {
        NetworkFetcher.shared.fetchWeatherData { [unowned self] (weatherData) in
            guard let weatherData = weatherData else { return }
            self.weatherData = weatherData
            completion()
        }
    }
    
    func numberOfTableViewRows() -> Int {
        weatherData?.fiveDayWeather?.daysWeather?.count ?? 0 // TODO: 1
    }
    
    func numberOfCollectionViewRows() -> Int {
        weatherData?.fiveDayWeather?.daysWeather?.first?.hoursWeather?.count ?? 0 // TODO: 2
    }
}
