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

    let decoder = JSONDecoder()
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    typealias WeatherCompletionHandler = (Weather?, Error?) -> Void
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, Error?) -> Void

    private func getWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, DarkSkyError.invalidUrl)
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, DarkSkyError.requestFailed)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(Weather.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, DarkSkyError.invalidData)
                    }

                } else if let error = error {
                    completion(nil, error)
                }
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
