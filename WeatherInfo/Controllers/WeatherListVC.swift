//
//  WeatherListVC.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherListVC: UIViewController {

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    private var arrayLocations: [WeatherViewModel] = []
    private let headerId = "WeatherCVHeaderView"
    private let cellId = "WeatherCVCell"
    private var weatherManager = WeatherManager()
    private var lastContentOffset: CGFloat = 0
    
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

extension WeatherListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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

    /// Cell For Row atr
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCVCell", for: indexPath) as! WeatherCVCell
        cell.updateUI(model: arrayLocations)
        return cell
    }
}

extension WeatherListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if lastContentOffset > scrollView.contentOffset.x && lastContentOffset < scrollView.contentSize.width {
            print("move left")
        } else if lastContentOffset < scrollView.contentOffset.x && scrollView.contentOffset.x > 0 {
            print("move right")
        }
        lastContentOffset = scrollView.contentOffset.x
    }
}
