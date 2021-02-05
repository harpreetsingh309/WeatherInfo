//
//  WeatherCVHeaderView.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherCVHeaderView: UICollectionReusableView {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        print("< > code")
    }
}
