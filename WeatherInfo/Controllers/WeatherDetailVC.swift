//
//  WeatherDetailVC.swift
//  WeatherInfo
//
//  Created by Harpreet on 06/02/21.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    private var arrayLocations: [WeatherViewModel] = []
    private let headerId = "WeatherCVHeaderView"
    private let cellId = "WeatherCVCell"
    private var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadLocationData()
    }
    
    func setupUI() {
        let nib = UINib(nibName: cellId, bundle: nil)
        weatherCollectionView.register(nib, forCellWithReuseIdentifier: cellId)
        let headerNib = UINib(nibName: headerId, bundle: nil)
        weatherCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }

    // MARK:- Fetch Given cities weather condition
    private func loadLocationData() {
        weatherManager.delegate = self
        weatherManager.fetchBulkWeather()
    }

    // MARK:- Alerts
    private func showAlert(_ msg: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Alert.showAlert(message: msg)
        }
    }
}
//MARK: - WeatherManagerDelegate

extension WeatherDetailVC: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherViewModel) {
        arrayLocations.append(weather)
        weatherCollectionView.reloadData()
    }
    
    func didUpdateBulkWeather(_ weatherManager: WeatherManager, weather: [WeatherViewModel]) {
        arrayLocations = weather
        print(arrayLocations)
        DispatchQueue.main.async {
            self.weatherCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: String) {
        showAlert(error)
    }
}

extension WeatherDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///Number of Sections in Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    ///Number of Rows in Sections in Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    /// Collection Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = weatherCollectionView.frame.width
        return CGSize(width: width, height: width * 1.8)
    }

    /// Cell For Row at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCVCell", for: indexPath) as! WeatherCVCell
        cell.updateUI(model: arrayLocations)
        return cell
    }
}
