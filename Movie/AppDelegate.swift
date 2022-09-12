//
//  AppDelegate.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        UserDefaults.standard.register(defaults: [UserDefaultsKey.isDarkMode.rawValue: true])
        UserDefaults.standard.synchronize()
        return true
    }
}

