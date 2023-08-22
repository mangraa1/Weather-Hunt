//
//  NetworkWeatherManager.swift
//  Weather Hunt
//
//  Created by mac on 21.08.2023.
//  Copyright © 2023 Heorhii Saienko. All rights reserved.
//

import Foundation

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.parsedJSON(withData: data)
            }
        }
        task.resume()
    }

    func parsedJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            print(currentWeatherData.main.feelsLike)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
