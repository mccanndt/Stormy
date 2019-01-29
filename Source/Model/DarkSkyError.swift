//
//  DarkSkyError.swift
//  Stormy
//
//  Created by David McCann on 1/28/19.
//  Copyright © 2019 Atomic Robot. All rights reserved.
//

import Foundation

enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidUrl
}
