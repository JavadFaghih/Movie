//
//  SplashInteractor.swift
//  Movie
//
//  Created by javad faghih on 9/9/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit
import Alamofire

typealias SplashInteractorInput = SplashViewControllerDelegate

class SplashInteractor: SplashInteractorInput {

    var worker: SplashNetWorkWorker?
  
    func viewDidload() {
        worker = SplashNetWorkWorker()
     
        worker?.requestForGetAppConfiguration { configuration in
            /* we cache this data in a user default because we may need this data on the whole app, also as mentioned in the API documentation we won't need to call this API each time the app runs, just after some days we need to refresh it */
            self.saveAPIConfigurationInUserDefaults(configuration: configuration)
        }
    }

    private func saveAPIConfigurationInUserDefaults(configuration: Data?) {
        
            let defaults = UserDefaults.standard
            let key = UserDefaultsKey.apiConfiguration.rawValue
            
            defaults.set(configuration, forKey: key)
            defaults.synchronize()
    }
}
