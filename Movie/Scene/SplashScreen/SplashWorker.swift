//
//  SplashWorker.swift
//  Movie
//
//  Created by javad faghih on 9/9/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import Foundation
import Alamofire

class SplashNetWorkWorker {
  
     func requestForGetAppConfiguration(complation: @escaping(_ configuration: Data?) -> Void)  {
       
        let baseURL = NetworkRequirment.baseURL.rawValue
        let configurationEndPoint = Configuration.getAPIConfiguration.rawValue
        let apiKey = NetworkRequirment.apiKey.rawValue
        
        let requestURL = "\(baseURL)\(configurationEndPoint)?api_key=\(apiKey)"
        
        AF.request(requestURL).responseData { result in
            
            switch result.result {
                
            case .success(let data):
                complation(data)
            case .failure(let failure):
                complation(nil)
                print(failure.localizedDescription)
            }
        }
    }
}
