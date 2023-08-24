//
//  CurrentWeather.swift
//  Weather Hunt
//
//  Created by mac on 22.08.2023.
//  Copyright © 2023 Heorhii Saienko. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let cityName: String

    let temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded())"
    }

    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }

    let conditionCode: Int

    init?(with currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
