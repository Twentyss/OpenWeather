//
//  CollectionViewCellViewModel.swift
//  OpenWeather
//
//  Created by Илья Першин on 11.02.2021.
//

import Foundation

protocol CollectionViewCellViewModelProtocol {
    var iconName: String { get }
    var selectedIconName: String { get }
    var hour: String { get }
    init (with hourWeather: Weather)
}

class CollectionViewCellViewModel: CollectionViewCellViewModelProtocol {
    var iconName: String {
        ImageService.getImageName(with:  hourWeather.iconName ?? "" )
    }
    
    var selectedIconName: String {
        iconName + ".fill"
    }
    
    var hour: String {
        hourWeather.time ?? ""
    }

    private let hourWeather: Weather
    
    required init(with hourWeather: Weather) {
        self.hourWeather = hourWeather
    }
}
