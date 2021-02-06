//
//  WeatherTableViewCell.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    func updateCell(with newModel: WeatherViewModel) {
        selectionStyle = .none
        lblCity.text =   setTimestamp(epochTime: Double(newModel.dateTime))
        lblDescription.text = newModel.desc.uppercased()
        lblTemp.text = newModel.temperatureString + Constants.degreeCelcius
        conditionImageView.image = UIImage(systemName: newModel.conditionName)
    }
    
    func setTimestamp(epochTime: Double) -> String {
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
            return dow + " at " + String(epochHour) + " PM"
        }
        return dow + " at " + String(epochHour) + " AM"
    }
}
