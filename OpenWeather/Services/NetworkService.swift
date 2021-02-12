//
//  NetworkManager.swift
//  OpenWeather
//
//  Created by Илья Першин on 11.02.2021.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private let urlString = "http://api.openweathermap.org/data/2.5/forecast?id=578072&appid=15a151ecc0fabd24775f7d8b0236fcdc"
    
    private init() {}
    
    func fetchWeatherJSONData(completion: @escaping (Data?) -> Void) {
        AF.request(urlString).validate().responseJSON { (response) in
            switch response.result {
            case .success(_):
                completion(response.data)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
