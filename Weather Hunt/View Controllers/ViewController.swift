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

        networkWeatherManager.onCompletion = { currentWeather in
            print(currentWeather.cityName)
        }

        networkWeatherManager.fetchCurrentWeather(forCity: "Kyiv")
    }

    //MARK: - @IBAction

    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        }
    }
}
