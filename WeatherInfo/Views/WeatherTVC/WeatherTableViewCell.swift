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

    func updateCell(with model: AnyObject) {
        selectionStyle = .none
        if let newModel = model as? WeatherViewModel {
            lblCity.text = newModel.cityName
            lblDescription.text = newModel.desc
            lblTemp.text = newModel.temperatureString + Constants.degreeCelcius
        }
    }
}
