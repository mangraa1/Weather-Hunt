//
//  ViewController.swift
//  Weather Hunt
//
//  Created by mac on 20.08.2023.
//

import UIKit

class ViewController: UIViewController {

    //MARK: @IBOutlets & Variables

    private var networkWeatherManager = NetworkWeatherManager()

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }

        networkWeatherManager.fetchCurrentWeather(forCity: "Kyiv")
    }

    //MARK: - Update Interface

    private func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }

    //MARK: - @IBAction

    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        }
    }
}
