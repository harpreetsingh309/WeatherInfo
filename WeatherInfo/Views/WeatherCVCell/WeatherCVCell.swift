//
//  WeatherCVCell.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherCVCell: UICollectionViewCell {

    lazy var widgetVC: WeatherWidgetVC = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WeatherWidgetVC") as! WeatherWidgetVC
            return vc
        }()

    override func awakeFromNib() {
        super.awakeFromNib()
        widgetVC.view.frame = self.contentView.bounds
        self.contentView.addSubview(widgetVC.view)
    }
    
    func updateUI(model: [WeatherViewModel]?) {
        if let newModel = model {
            widgetVC.modelWeather = newModel
            widgetVC.weatherTableView.reloadData()
        }
    }
}
