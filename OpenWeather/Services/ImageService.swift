//
//  ImageService.swift
//  OpenWeather
//
//  Created by Илья Першин on 14.02.2021.
//

import Foundation
import Alamofire

class ImageService {
    static func getImageName(with iconName: String) -> String {
        switch iconName {
        case "01d", "01n": return "sun.min"
        case "02d", "02n": return "cloud.sun"
        case "03d", "03n": return "cloud"
        case "04d", "04n": return "cloud"
        case "05d", "05n": return "cloud.rain"
        case "06d", "06n": return "cloud.drizzle"
        case "07d", "07n": return "cloud.bolt"
        case "08d", "08n": return "cloud.snow"
        case "09d", "09n": return "cloud.fog"
        default:
            return "cloud"
        }
    }
}
