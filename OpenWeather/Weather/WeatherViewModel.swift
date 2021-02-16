//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Илья Першин on 10.02.2021.
//

import Foundation

protocol WeatherViewModelProtocol: class {
    var weatherData: WeatherData! { get }
    func fetchWeatherData(completion: @escaping() -> Void)
    func numberOfTableViewRows() -> Int
    func numberOfCollectionViewRows(at index: Int) -> Int
}

class WeatherViewModel: WeatherViewModelProtocol {
    var weatherData: WeatherData!
    
    func fetchWeatherData(completion: @escaping () -> Void) {
        NetworkFetcher.shared.fetchWeatherData { [unowned self] (weatherData) in
            guard let weatherData = weatherData else { return }
            self.weatherData = weatherData
            completion()
        }
    }
    
    func numberOfTableViewRows() -> Int {
        weatherData?.fiveDayWeather.daysWeather.count ?? 0 
    }
    
    func numberOfCollectionViewRows(at index: Int) -> Int {
        weatherData?.fiveDayWeather.daysWeather[index].hoursWeather.count ?? 0
    }
}
