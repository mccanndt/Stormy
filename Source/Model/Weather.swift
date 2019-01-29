//
//  Weather.swift
//  Stormy
//
//  Created by David McCann on 1/28/19.
//  Copyright © 2019 Atomic Robot. All rights reserved.
//

import Foundation

struct Weather {
    let currently: CurrentWeather
}

extension Weather {
    init?(json: [String: AnyObject]) {
        guard let currentWeatherJson = json["currently"] as? [String: AnyObject], let currentWeather = CurrentWeather(json: currentWeatherJson) else {
            return nil
        }

        self.currently = currentWeather
    }
}
