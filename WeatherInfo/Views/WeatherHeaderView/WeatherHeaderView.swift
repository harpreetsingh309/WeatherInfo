//
//  WeatherHeaderView.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    var weather: WeatherViewModel?
    
    override func awakeFromNib() {
//        setUI()
    }

    func setUI() {
        if let model = weather {
            temperatureLabel.text = model.temperatureString
            minMaxLabel.text = model.tempMinString + " / " + model.tempMaxString
            conditionImageView.image = UIImage(systemName: model.conditionName)
            cityLabel.text = model.cityName
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
