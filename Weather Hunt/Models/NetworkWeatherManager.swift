//
//  NetworkWeatherManager.swift
//  Weather Hunt
//
//  Created by mac on 21.08.2023.
//  Copyright © 2023 Heorhii Saienko. All rights reserved.
//

import Foundation

class NetworkWeatherManager {

    //MARK: Variables

    var onCompletion: ((CurrentWeather) -> Void)?

    //MARK: - Public

    public func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
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

    //MARK: - Private

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
