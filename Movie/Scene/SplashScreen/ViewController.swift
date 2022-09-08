//
//  ViewController.swift
//  Movie
//
//  Created by Javad on 08.09.22.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.changeRootController()
        }
        
        requestForGetAppConfiguration()
    }
    
    private func changeRootController() {
             
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchNavigationController")  as? UINavigationController else { return }

        window.rootViewController = vc

        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.7

        UIView.transition(with: window, duration: duration, options: options, animations: {})
        
    }
    
    
    
    private func requestForGetAppConfiguration () {
        /* we cache this data in a user default because we may need this data on the whole app, also as mentioned in the API documentation we won't need to call this API each time the app runs, just after some days we need to refresh it */
        
        let baseURL = NetworkRequirment.baseURL.rawValue
        let configurationEndPoint = Configuration.getAPIConfiguration.rawValue
        let apiKey = NetworkRequirment.apiKey.rawValue
        
        let requestURL = "\(baseURL)\(configurationEndPoint)?api_key=\(apiKey)"
        
        AF.request(requestURL).responseData { result in
            
            switch result.result {
                
            case .success(let data):
                self.saveAPIConfigurationInUserDefaults(configuration: data)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func saveAPIConfigurationInUserDefaults(configuration: Data) {
        
            let defaults = UserDefaults.standard
            let key = UserDefaultsKey.apiConfiguration.rawValue
            
            defaults.set(configuration, forKey: key)
            defaults.synchronize()
    }
}
