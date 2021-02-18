//
//  TableViewCell.swift
//  OpenWeather
//
//  Created by Илья Першин on 11.02.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weakDayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var viewModel: WeatherTableViewCellViewModelProtocol! {
        didSet {
            dateLabel.text = viewModel.date
            weakDayLabel.text = viewModel.weekDay
            temperatureLabel.text = viewModel.temperature
            weatherIcon.image = UIImage(systemName: viewModel.iconName)
        }
    }
}
