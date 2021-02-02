//
//  UIApplication.swift
//  WeatherMap
//
//  Created by Harpreet on 02/02/21.
//  Copyright © 2020 Harpreet. All rights reserved.
//

import UIKit

// MARK: - Get Root view or Scene Controller
extension UIApplication {
    
    class var scene: UIViewController! {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        return sceneDelegate.window?.rootViewController
    }
    
    class var appWindow: UIWindow! {
        return (UIApplication.shared.delegate?.window!)!
    }
    
    class var rootViewController: UIViewController! {
        return self.appWindow.rootViewController!
    }
    
    class var visibleViewController: UIViewController! {
        return self.rootViewController.findContentViewControllerRecursively()
    }
}
