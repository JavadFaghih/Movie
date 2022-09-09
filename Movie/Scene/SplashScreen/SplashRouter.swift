//
//  SplashRouter.swift
//  Movie
//
//  Created by javad faghih on 9/9/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SplashRoutingLogic {
    func changeRoot()
}

class SplashRouter: NSObject, SplashRoutingLogic {

    weak var viewController: SplashViewController?
    private  let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

    func changeRoot() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { self.changeRootController() }
    }
    
    private func changeRootController() {
             
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return }

        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchNavigationController")  as? UINavigationController else { return }

        window.rootViewController = vc

        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.7

        UIView.transition(with: window, duration: duration, options: options, animations: {})
        
    }
}
