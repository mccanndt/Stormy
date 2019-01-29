//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by David McCann.
//  Copyright © David McCann. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    fileprivate let darkSkyApiKey = "46d87bd8a1ab203208b6ab663b32abe5"

    lazy var baseURL: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }()

    let downloader = JSONDownloader()

    typealias WeatherCompletionHandler = (Weather?, DarkSkyError?) -> Void
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?) -> Void

    private func getWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, .invalidUrl)
            return
        }

        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }

                guard let weather = Weather(json: json) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }

                completion(weather, nil)
            }
        }

        task.resume()
    }

    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        getWeather(at: coordinate) { weather, error in
            completion(weather?.currently, error)
        }
    }
}
