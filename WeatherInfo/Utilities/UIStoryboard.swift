//
//  UIStoryboard.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class var main: UIStoryboard {
        let storyboardName: String = (Bundle.main.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String)!
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

private final class BundleToken {}

struct SceneType<T: Any> {
    let storyboard: StoryboardType.Type
    let identifier: String
    
    func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }
}

protocol StoryboardType {
    static var storyboardName: String { get }
}

extension StoryboardType {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
    }
}

enum StoryBoardMain: StoryboardType {
    static let storyboardName = "Main"
//    static let detailVC = SceneType<WeatherInfo.WeatherDetailVC>(storyboard: StoryBoardMain.self, identifier: "WeatherDetailVC")
}
