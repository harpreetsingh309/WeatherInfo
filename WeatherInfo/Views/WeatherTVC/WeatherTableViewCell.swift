//
//  WeatherTableViewCell.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    func updateCell(with newModel: WeatherViewModel, isDetail: Bool = false) {
        selectionStyle = .none
        if isDetail {
            dateTimeLabel.text = newModel.dateString
        } else {
            dateTimeLabel.text = newModel.dateTimeString
        }
        descriptionLabel.text = newModel.desc.uppercased()
        temperatureLabel.text = newModel.temperatureString + Constants.degreeCelcius
        conditionImageView.image = UIImage(systemName: newModel.conditionName)
    }
}
