//
//  AppDelegate.swift
//  Junction2024-Team9
//
//  Created by Damin on 8/11/24.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let locationHelper = LocationHelper.shared

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        locationHelper.checkLocationAuthorization()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }
}
