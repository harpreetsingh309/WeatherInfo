//
//  WeatherManager.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateBulkWeather(_ weatherManager: WeatherManager, weather: [[WeatherViewModel]])
    func didFailWithError(error: String)
}

class WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    var activityView: UIActivityIndicatorView?
    
    // MARK:- Get API Key
    private var getAPIKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                fatalError("Couldn't find file Info.plist")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key")
            }
            return value
        }
    }

    // MARK:- Get data from JSON file
    private func getJsonFileData(fileName: String) -> [WeatherViewModel]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            let decoder = JSONDecoder()
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decodedData = try decoder.decode(WeatherListDataModel.self, from: data)
                var list: [WeatherViewModel] = []
                for model in decodedData.list {
                    let id = model.weather[0].id
                    let temp = model.main.temp
                    let name = decodedData.city.name
                    let desc = model.weather[0].description
                    let min = model.main.temp_min
                    let dt = model.dt
                    let max = model.main.temp_max
                    let humidity = model.main.humidity
                    let weather = WeatherViewModel(conditionId: id, dateTime: dt, cityName: name, temperature: temp, humidity: humidity , temp_min: min, temp_max: max, desc: desc)
                    list.append(weather)
                }
                return list
            } catch {
                   // handle error
                print("Unable to load data")
              }
        }
        return nil
    }
    
    // MARK:- API call
    func fetchBulkWeather(cityID: cities) {
        showActivityIndicator()
        let urlString = "\(Constants.cityWeatherBaseURL)&id=\(cityID.rawValue)&appid=\(getAPIKey)"
        performRequest(with: urlString)
    }
    
    // MARK:- URLSession Task
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {[weak self] (data, response, error) in
                if error != nil {
                    self?.hideActivityIndicator()
                    self?.delegate?.didFailWithError(error: Errors.serverError)
                    return
                }
                if let safeData = data {
                    if let weather = self?.parseBulkJSON(safeData) {
                        self?.hideActivityIndicator()
                        self?.delegate?.didUpdateBulkWeather(self!, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseBulkJSON(_ weatherData: Data) -> [[WeatherViewModel]]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherListDataModel.self, from: weatherData)
            var list: [WeatherViewModel] = []
            var model = [[WeatherViewModel]]()
            for model in decodedData.list {
                let id = model.weather[0].id
                let temp = model.main.temp
                let name = decodedData.city.name
                let desc = model.weather[0].description
                let min = model.main.temp_min
                let dt = model.dt
                let max = model.main.temp_max
                let humidity = model.main.humidity
                let weather = WeatherViewModel(conditionId: id, dateTime: dt, cityName: name, temperature: temp, humidity: humidity , temp_min: min, temp_max: max, desc: desc)
                list.append(weather)
            }
            model.append(list)
            if let hobart = getJsonFileData(fileName: "hobart") {
                model.append(hobart)
            }
            if let perth = getJsonFileData(fileName: "perth") {
                model.append(perth)
            }
            return model
            
        } catch {
            hideActivityIndicator()
            delegate?.didFailWithError(error: Errors.serverError)
            return nil
        }
    }
    
    // MARK:-  Activity Indicator
    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = .white
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.activityView!.center = UIApplication.scene.view.center
            UIApplication.scene.view.addSubview(self.activityView!)
            self.activityView!.startAnimating()
        }
    }
    
    private func hideActivityIndicator(){
        if (activityView != nil){
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.activityView?.stopAnimating()
            }
        }
    }
}
