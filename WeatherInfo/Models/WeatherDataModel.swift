//
//  WeatherDataModel.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import Foundation

struct WeatherListDataModel: Codable {
    let list: [WeatherDataModel]
}

struct WeatherDataModel: Codable {
    let name: String
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
