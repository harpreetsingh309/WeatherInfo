//
//  Constants.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import Foundation

struct Constants {
    static let cityWeatherBaseURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric"
    static let degreeCelcius = "°C"
}

struct AlertConstant {
    static let alertOK = "OK"
    static let alertCancel = "Cancel"
    static let alertSearch = "Search"
}

struct Errors {
    static let noInternet = "Your Internet connection appears to be offline."
    static let serverError = "Internal Server error ocurred, try again after some time"
}
