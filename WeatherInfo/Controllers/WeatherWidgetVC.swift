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
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: cellID, bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: cellID)
        weatherTableView.backgroundColor = .clear
        let header = UINib(nibName: "WeatherHeaderView", bundle: nil)
        weatherTableView.sectionHeaderHeight = self.view.frame.height/2
        weatherTableView.register(header, forHeaderFooterViewReuseIdentifier: "WeatherHeaderView")
    }
    
}

extension WeatherWidgetVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.weatherTableView.dequeueReusableHeaderFooterView(withIdentifier: "WeatherHeaderView")  as! WeatherHeaderView
        view.contentView.backgroundColor = .black
        return view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherTableViewCell
        return cell
    }
}
