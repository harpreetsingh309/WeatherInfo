//
//  WeatherListVC.swift
//  WeatherInfo
//
//  Created by Harpreet on 02/02/21.
//

import UIKit

class WeatherListVC: UIViewController {

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    private var arrPatient: [String] = []
    private var isCellSelected = false
    private var isSectionSelected = false
    private let headerId = "WeatherCVHeaderView"
    private let cellId = "WeatherCVCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let nib = UINib(nibName: cellId, bundle: nil)
        weatherCollectionView.register(nib, forCellWithReuseIdentifier: cellId)
        let headerNib = UINib(nibName: headerId, bundle: nil)
        weatherCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
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

    /// Cell For Row at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCVCell", for: indexPath) as! WeatherCVCell
        return cell
    }
}
