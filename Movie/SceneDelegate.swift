//
//  SceneDelegate.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var isDark: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKey.isDarkMode.rawValue)
        }
    }
    var window: UIWindow? {
        didSet {
            window?.overrideUserInterfaceStyle = !isDark ? .dark : .light
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

