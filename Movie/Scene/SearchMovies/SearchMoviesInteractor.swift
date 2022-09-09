//
//  SearchMoviesInteractor.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import Alamofire
import Foundation

protocol SearchMoviesinteractorDelegate {
    func presentMovies(response: [SearchMovieResult]?)
}

protocol SearchMoviesDataStore {
  var items: SearchMovieResponseModel? { get }
  var movies: [SearchMovieResult] { get set}
}

typealias SearchMoviesInteractorInput = SearchMoviesViewControllerDelegate

class SearchMoviesInteractor: SearchMoviesInteractorInput, SearchMoviesDataStore {
    
    var presenter: SearchMoviesinteractorDelegate?
    var worker: SearchMoviesWorker?
    var items: SearchMovieResponseModel?
    var movies: [SearchMovieResult] = []
    private var requestPage: Int = 1
    private var movieNameSearched: String?
    
    func requestForSearchMovie(with: String) {
        self.items = nil
        self.movies.removeAll()
        self.requestPage = 1
        self.movieNameSearched = with
        self.requestMovie(with: with)
    }
    
    func requestForNexPageIfNedded() {
        guard let movies = items else { return }
        guard let currentPage = movies.page else { return }
        guard let lastPage = movies.totalPages else { return }
        guard let movieName = movieNameSearched else { return }
        
        if currentPage < lastPage {
            requestPage += 1
            requestMovie(with: movieName, page: requestPage)
        }
    }
    
    private func requestMovie(with word: String, page: Int = 1) {
        
        let baseURL = NetworkRequirment.baseURL.rawValue
        let searchMoviewEndPoint = Search.searchMovie.rawValue
        let apiKey = NetworkRequirment.apiKey.rawValue
        
        let requestURL = "\(baseURL)\(searchMoviewEndPoint)?api_key=\(apiKey)&language=en-US&query=\(word)&page=\(page)&include_adult=false"
        
       let urlString = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
               
                if  let model = try? JSONDecoder().decode(SearchMovieResponseModel.self, from: data) {
                  
                    defer {
                        self.presenter?.presentMovies(response: self.movies)
                    }
                    
                    self.items = model
                    self.movies.append(contentsOf: model.results)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
