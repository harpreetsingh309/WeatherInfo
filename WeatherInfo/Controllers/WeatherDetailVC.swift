//
//  WeatherDetailVC.swift
//  WeatherInfo
//
//  Created by Harpreet on 07/02/21.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!

    var headerString = ""
    var modelWeather: [WeatherViewModel]?
    private let cellID = "WeatherTableViewCell"
    private var weatherManager = WeatherManager()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        headerLabel.text = headerString
        let nib = UINib(nibName: cellID, bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: cellID)
        modelWeather = weatherManager.getJsonFileData(fileName: "nextDaysData")
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
}

extension WeatherDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = modelWeather, model.count > 0 {
            return model.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherTableViewCell
        if let model = modelWeather, model.count > 0 {
            cell.updateCell(with: model[indexPath.row], isDetail: true)
        }
        return cell
    }
}
