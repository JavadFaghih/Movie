//
//  MovieDetailsWorker.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import Alamofire
import Foundation

class MovieDetailsWorker {
  
    func loadImage(url: String, complation: @escaping(_ image: Data?) -> Void) {
        
        AF.request(url).responseData { response in
            
            switch response.result {
            
            case .success(let data):
                complation(data)
            case .failure(let error):
                print(error.localizedDescription)
                complation(nil)
            }
        }
    }
    
    func getMovieDetails(with id: Int, complation: @escaping(_ result: Result<MovieDetails.Models.MovieDetailsResponse, NetworkErrorType>) -> Void) { //
        
        let baseURL = NetworkRequirment.baseURL.rawValue
        let movieEndpoint = MovieEndpoints.movieDetails.rawValue
        let apiKey = NetworkRequirment.apiKey.rawValue
        
        let urlRequest = "\(baseURL)\(movieEndpoint)\(id)?api_key=\(apiKey)&language=en-US"
        
        AF.request(urlRequest).responseData { response in
          
            switch response.result {
            
            case .success(let data):
              
                if let model = try? JSONDecoder().decode(MovieDetails.Models.MovieDetailsResponse.self, from: data) {
                    complation(.success(model))
                    
                }
                return
            case .failure(_):
                break
            }
            if response.response?.statusCode == -1001 {
                complation(.failure(.timeOut))
                return
            } else {
                complation(.failure(.failed))
                return
            }
        }
    }
}
