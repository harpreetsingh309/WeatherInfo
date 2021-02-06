//
//  WeatherWidgetVC.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherWidgetVC: UIViewController {
    @IBOutlet weak var weatherTableView: UITableView!
    private let cellID = "WeatherTableViewCell"
    private let headerID = "WeatherHeaderView"
    var modelWeather: [WeatherViewModel]?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: cellID, bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: cellID)
        let header = UINib(nibName: headerID, bundle: nil)
        weatherTableView.sectionHeaderHeight = self.view.frame.height/2.3
        weatherTableView.register(header, forHeaderFooterViewReuseIdentifier: headerID)
    }
    
}

extension WeatherWidgetVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.weatherTableView.dequeueReusableHeaderFooterView(withIdentifier: headerID)  as! WeatherHeaderView
        view.contentView.backgroundColor = .black
        if let model = modelWeather, model.count > 0 {
            view.weather = model[0]
            view.setUI()
        }
        return view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = modelWeather, model.count > 0 {
            return model.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherTableViewCell
        if let model = modelWeather, model.count > 0 {
            cell.updateCell(with: model[indexPath.row])
        }
        return cell
    }
}
