//
//  CurrentWeather.swift
//  Stormy
//
//  Created by David McCann.
//  Copyright © David McCann. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let precipProbability: Double
    let summary: String
    let icon: String
}

extension CurrentWeather {
    var iconImage: UIImage {
        switch icon {
        case "clear-day": return #imageLiteral(resourceName: "clear-day.png")
        case "clear-night": return #imageLiteral(resourceName: "clear-night.png")
        case "rain": return #imageLiteral(resourceName: "rain.png")
        case "snow": return #imageLiteral(resourceName: "snow.png")
        case "sleet": return #imageLiteral(resourceName: "sleet.png")
        case "wind": return #imageLiteral(resourceName: "wind.png")
        case "fog": return #imageLiteral(resourceName: "fog.png")
        case "cloudy": return #imageLiteral(resourceName: "cloudy.png")
        case "partly-cloudy-day": return #imageLiteral(resourceName: "partly-cloudy-day")
        case "partly-cloudy-night": return #imageLiteral(resourceName: "partly-cloudy-night")
        default: return #imageLiteral(resourceName: "default.png")
        }
    }
}

extension CurrentWeather {
    struct Key {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
    }
    init?(json: [String: AnyObject]) {
        guard let tempValue = json[Key.temperature] as? Double,
        let humidityValue = json[Key.humidity] as? Double,
        let precipProbabilityValue = json[Key.precipProbability] as? Double,
        let summaryString = json[Key.summary] as? String,
        let iconString = json[Key.icon] as? String else {
            return nil
        }

        self.temperature = tempValue
        self.humidity = humidityValue
        self.precipProbability = precipProbabilityValue
        self.summary = summaryString
        self.icon = iconString
    }
}
