//
//  WeatherListVC.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherListVC: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    private var arrayLocations: [WeatherViewModel] = []
    private let cellID = "WeatherTableViewCell"
    private var weatherManager = WeatherManager()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: cellID, bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: cellID)
        loadTableData()
        loadLocationData()
    }
    
    // MARK:- Table View Observer
    private func loadTableData() {
//        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
//            self.arrayLocations.asObservable().bind(to: self.weatherTableView.rx.items(cellIdentifier: self.cellID, cellType: WeatherTableViewCell.self)) { index,item,cell in
//                cell.updateCell(with: item as AnyObject)
//            }.disposed(by: self.disposeBag)
//        })
    }
    
    // MARK:- Fetch Given cities weather condition
    private func loadLocationData() {
        weatherManager.fetchBulkCitiesWeather()
    }
    
    // MARK:- Alerts
    
    private func showAlert(_ msg: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Alert.showAlert(message: msg)
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherListVC: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherViewModel) {
//        arrayLocations = weather
    }
    
    func didUpdateBulkWeather(_ weatherManager: WeatherManager, weather: [WeatherViewModel]) {
        arrayLocations = weather
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
    
    func didFailWithError(error: String) {
        showAlert(error)
    }
}

//MARK:- Tableview delegate and datasource methods

extension WeatherListVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLocations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherTableViewCell
        cell.updateCell(with: arrayLocations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passvc = StoryBoardMain.detailVC.instantiate()
//        passvc.weather = arrayLocations.value[indexPath.row]
        self.present(passvc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.strDelete) { (action, view, handler) in
            self.arrayLocations.remove(at: indexPath.row)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
