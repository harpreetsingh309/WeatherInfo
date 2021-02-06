//
//  WeatherDataModel.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import Foundation

enum cities: String {
    case sydney = "2147714"
    case hobart = "2163355"
    case perth = "2063523"
}

struct WeatherListDataModel: Codable {
    let list: [WeatherDataModel]
    let city: WeatherCityModel
}

struct WeatherCityModel: Codable {
    let name: String
}

struct WeatherDataModel: Codable {
    let dt: Int
    let main: MainTemperature
    let weather: [WeatherCondition]
}

struct MainTemperature: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct WeatherCondition: Codable {
    let description: String
    let id: Int
}
