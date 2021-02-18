//
//  NetworkManager.swift
//  OpenWeather
//
//  Created by Илья Першин on 11.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    static let shared = NetworkService()
    
    private let weatherDataUrlString = "http://api.openweathermap.org/data/2.5/forecast?id=578072&appid=15a151ecc0fabd24775f7d8b0236fcdc"
    
    private init() {}

    func fetchWeatherData(completion: @escaping (WeatherData?) -> Void) {
        self.fetchWeatherJSONData { (data) in
            guard
                let data = data
            else {
                completion(nil)
                return
            }
            
            do {
                let json = try JSON(data: data)
                
                let weatherData = WeatherData(with: json)
                
                completion(weatherData)
            } catch let error {
                print("Error (in fetchWeatherData \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    private func fetchWeatherJSONData(completion: @escaping (Data?) -> Void) {
        AF.request(weatherDataUrlString).validate().responseJSON { (response) in
            switch response.result {
            case .success(_):
                completion(response.data)
            case .failure(let error):
                print("Error (in fetchWeatherJSONData: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
