//
//  ViewController.swift
//  OpenWeather
//
//  Created by Илья Першин on 10.02.2021.
//

import UIKit
import SwiftyJSON
class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    private var currentIndex = 0
    
    private var viewModel: WeatherViewModelProtocol! {
        didSet {
            fetchData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherViewModel()
    }

    @IBAction func updateButtonPressed() {
        fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchWeatherData { [unowned self] in 
            if self.viewModel.weatherData != nil {
                self.cityNameLabel.text = self.viewModel.weatherData?.cityName
                self.setLabels()
                self.tableView.reloadData()
                self.collectionView.reloadData()
            } else {
                self.showErrorAlert()
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Update error", message: "Сheck your internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func setImage(with iconName: String) {
        imageView.image = UIImage(named: iconName)
    }
    
    private func setLabels(at index: Int = 0) {
        weatherDescriptionLabel.text =
            viewModel.weatherData?
            .fiveDayWeather.daysWeather[currentIndex]
            .hoursWeather[index].description
        
        temperatureLabel.text =
            viewModel.weatherData?
            .fiveDayWeather.daysWeather[currentIndex]
            .hoursWeather[index].temperature
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! WeatherTableViewCell
        
        if viewModel.weatherData != nil {
            cell.viewModel = WeatherTableViewModel(with: (viewModel.weatherData?.fiveDayWeather.daysWeather[indexPath.item])!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfTableViewRows()
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numberOfRows = viewModel.numberOfTableViewRows()
        return tableView.frame.height / CGFloat(numberOfRows)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.item
        setLabels()
        collectionView.reloadData()
    }
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        
        if viewModel.weatherData != nil {
            let cellViewModel = CollectionViewCellViewModel(with: (viewModel.weatherData?.fiveDayWeather.daysWeather[currentIndex].hoursWeather[indexPath.item])!)
            
            cell.viewModel = cellViewModel
            
            if indexPath.item == 0 {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                cell.isSelected = true
                setImage(with: cell.viewModel.iconName)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCollectionViewRows(at: currentIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WeatherCollectionViewCell
        setImage(with: cell.viewModel.iconName)
        setLabels(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfRows = viewModel.numberOfCollectionViewRows(at: currentIndex)
        return CGSize(width: collectionView.layer.frame.width / CGFloat(numberOfRows), height: collectionView.layer.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

