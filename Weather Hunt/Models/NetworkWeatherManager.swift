//
//  NetworkWeatherManager.swift
//  Weather Hunt
//
//  Created by mac on 21.08.2023.
//  Copyright © 2023 Heorhii Saienko. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {

    //MARK: Enum

    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }

    //MARK: - Variables

    public var onCompletion: ((CurrentWeather) -> Void)?

    //MARK: - Public

    public func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""

        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }

    //MARK: - Private

    private func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parsedJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }

    private func parsedJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)

            guard let currentWeather = CurrentWeather(with: currentWeatherData) else {
                return nil
            }
            return currentWeather

        } catch let error as NSError {
            print(error.localizedDescription)
        }

        return nil
    }
}
