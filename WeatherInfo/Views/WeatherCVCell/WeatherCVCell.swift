//
//  WeatherCVCell.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherCVCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
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
}
