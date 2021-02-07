//
//  WeatherListVC.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherListVC: UIViewController {

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    private var arrayLocations: [[WeatherViewModel]] = []
    private let headerId = "WeatherCVHeaderView"
    private let cellId = "WeatherCVCell"
    private var weatherManager = WeatherManager()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadLocationData()
    }
    
    // MARK:- Register cell/nib
    func setupUI() {
        var nib = UINib(nibName: cellId, bundle: nil)
        weatherCollectionView.register(nib, forCellWithReuseIdentifier: cellId)
        nib = UINib(nibName: headerId, bundle: nil)
        weatherCollectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }

    // MARK:- Fetch Given cities weather condition
    private func loadLocationData() {
        weatherManager.delegate = self
        weatherManager.fetchBulkWeather(cityID: .sydney)
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
    
    func didUpdateBulkWeather(_ weatherManager: WeatherManager, weather: [[WeatherViewModel]]) {
        arrayLocations = weather
        DispatchQueue.main.async {
            self.weatherCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: String) {
        showAlert(error)
    }
}

extension WeatherListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///Number of Sections in Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    ///Number of Rows in Sections in Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayLocations.count
    }

    /// Collection Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = weatherCollectionView.frame.width
        return CGSize(width: width, height: width * 1.8)
    }

    /// Cell For Row at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeatherCVCell
        cell.updateUI(model: arrayLocations[indexPath.row])
        return cell
    }
}
