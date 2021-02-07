//
//  WeatherModel.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import Foundation

struct WeatherViewModel {
    let conditionId: Int
    let dateTime: Int
    let cityName: String
    let temperature: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
    let desc: String

    var temperatureString: String {
        return temperature.toString()
    }

    var humidityString: String {
        return humidity.toString() + "%"
    }

    var tempMaxString: String {
        return temp_max.toString() + Constants.degreeCelcius
    }

    var tempMinString: String {
        return temp_min.toString() + Constants.degreeCelcius
    }

    var conditionName: String {
        switch conditionId {
        case 200...232, 800:
            return "sun.max"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "snow"
        case 701...781:
            return "wind"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.max"
        }
    }
    
    var dateTimeString: String {
        let epochTime = Double(dateTime)
        let epochDate = Date(timeIntervalSince1970: epochTime)
        let calendar = Calendar.current
        let epochHour = calendar.component(.hour, from: epochDate)
        let calender = Calendar(identifier: .gregorian)
        let comps = calender.dateComponents([.weekday], from: epochDate)
        let today = comps.weekday!
        var dow = ""
        switch today {
        case 1: dow = "Sunday"
        case 2: dow = "Monday"
        case 3: dow = "Tuesday"
        case 4: dow = "Wednesday"
        case 5: dow = "Thursday"
        case 6: dow = "Friday"
        case 7: dow = "Saturday"
        default: dow = ""
        }
        if epochHour > 12 {
            return dow + " at " + String(epochHour-12) + " PM"
        }
        return dow + " at " + String(epochHour) + " AM"
    }
}

// MARK:- Double to String
extension Double {
    func toString() -> String {
        return String(format: "%.0f",self)
    }
}
