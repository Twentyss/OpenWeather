//
//  CollectionViewCell.swift
//  OpenWeather
//
//  Created by Илья Першин on 11.02.2021.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                weatherImage.image = UIImage(systemName: viewModel.selectedIconName)
            } else {
                weatherImage.image = UIImage(systemName: viewModel.iconName)
            }
        }
    }
    
    var viewModel: CollectionViewCellViewModelProtocol! {
        didSet {
            weatherImage.image = UIImage(systemName: viewModel.iconName)
            timeLabel.text = viewModel.hour
        }
    }
}
