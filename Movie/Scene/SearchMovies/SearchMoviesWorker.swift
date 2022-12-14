//
//  SearchMoviesWorker.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit
import Alamofire

class SearchMoviesWorker {
    
    func requestMovie(with word: String, page: Int = 1, complation: @escaping(_ result: Swift.Result<SearchMovies.Models.SearchMovieResponseModel, NetworkErrorType>) -> Void) {
        
        let baseURL = NetworkRequirment.baseURL.rawValue
        let searchMoviewEndPoint = Search.searchMovie.rawValue
        let apiKey = NetworkRequirment.apiKey.rawValue
        
        let requestURL = "\(baseURL)\(searchMoviewEndPoint)?api_key=\(apiKey)&language=en-US&query=\(word)&page=\(page)&include_adult=false"
        
        let urlString = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        AF.request(urlString).responseData { response in
            
            switch response.result {
            
            case .success(let data):
                
                if  let model = try? JSONDecoder().decode(SearchMovies.Models.SearchMovieResponseModel.self, from: data) {
                    
                    if model.results.isEmpty {
                        complation(.failure(.noData))
                        return
                    } else {
                        complation(.success(model))
                        return
                    }
                }
                complation(.failure(.failed))
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
