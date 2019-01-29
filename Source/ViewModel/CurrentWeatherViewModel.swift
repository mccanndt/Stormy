//
//  CurrentWeatherViewModel.swift
//  Stormy
//
//  Created by David McCann.
//  Copyright © David McCann. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipProbability: String
    let summary: String
    let icon: UIImage

    init(model: CurrentWeather) {
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)º"

        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"

        let precipPercentValue = Int(model.precipProbability * 100)
        self.precipProbability = "\(precipPercentValue)%"

        self.summary = model.summary
        self.icon = model.iconImage
    }
}
