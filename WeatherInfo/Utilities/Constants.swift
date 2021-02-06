//
//  Constants.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import Foundation

struct Constants {
    static let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    static let bulkWeatherBaseURL = "https://api.openweathermap.org/data/2.5/group?units=metric&id=4163971,2147714,2174003"
    static let cityWeatherBaseURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&id=2147714" // "https://api.openweathermap.org/data/2.5/group?units=metric&id=4163971,2147714,2174003"
    static let degreeCelcius = "°C"
    static let strSearch = "Search"
    static let strDelete = "Delete"
}

struct AlertConstant {
    static let alertMsg = "You can search weather from city name"
    static let alertTextfield = "Enter city name here"
    static let alertOK = "OK"
    static let alertCancel = "Cancel"
    static let alertSearch = "Search"
    static let alertSetting = "App need to access your location, turn on Location Services in your device settings."
    
}

struct Errors {
    static let noInternet = "Your Internet connection appears to be offline."
    static let cantFindLoc = "Can't able to find your location."
    static let cantFindCity = "City not found!!\nPlease try different one"
    static let serverError = "Internal Server error ocurred, try again after some time"
    static let EmptyError = "Please enter city name"
}
