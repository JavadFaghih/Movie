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
    func presentMovies(response: [SearchMovieResult]?, totalResult: Int)
    func presentError(with description: String )
}

protocol SearchMoviesDataStore {
    var items: SearchMovieResponseModel? { get }
    var movies: [SearchMovieResult] { get set}
    var totlaResults: Int { get }
}

typealias SearchMoviesInteractorInput = SearchMoviesViewControllerDelegate

class SearchMoviesInteractor: SearchMoviesInteractorInput, SearchMoviesDataStore {
    
    var presenter: SearchMoviesinteractorDelegate?
    var worker: SearchMoviesWorker?
    var items: SearchMovieResponseModel?
    var movies: [SearchMovieResult] = []
    var totlaResults: Int = 0
    private var requestPage: Int = 1
    private var movieNameSearched: String?
    
    func viewDidLoad() {
        worker = SearchMoviesWorker()
    }
    
    func requestForSearchMovie(with: String) {
        self.items = nil
        self.movies.removeAll()
        self.requestPage = 1
        self.movieNameSearched = with
        
        self.requestMovie(word: with)
    }
    
    func requestForNexPageIfNedded() {
        guard let movies = items else { return }
        guard let currentPage = movies.page else { return }
        guard let lastPage = movies.totalPages else { return }
        guard let movieName = movieNameSearched else { return }
        
        if currentPage < lastPage {
            requestPage += 1
            requestMovie(word: movieName, page: requestPage)
        }
    }
    
    private func requestMovie(word: String, page: Int = 1) {
        
        worker?.requestMovie(with: word, page: page) { [weak self] response in
            
            switch response {
            
            case .success(let item):
                
                self?.items = item
                self?.totlaResults = item.totalResults ?? 0
                self?.movies.append(contentsOf: item.results)
                self?.presenter?.presentMovies(response: self?.movies, totalResult: self?.totlaResults ?? 0)
                
            case .failure(let error):
                self?.presenter?.presentError(with: error.description)
            }
        }
    }
}
