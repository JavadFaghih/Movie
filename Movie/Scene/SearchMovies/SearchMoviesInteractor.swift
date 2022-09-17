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
    func presentMovies(response: [SearchMovies.Models.SearchMovieResult]?, totalResult: Int)
    func presentError(with description: String )
}

protocol SearchMoviesDataStore {
    var items: SearchMovies.Models.SearchMovieResponseModel? { get }
    var movies: [SearchMovies.Models.SearchMovieResult] { get set}
    var totlaResults: Int { get }
}

typealias SearchMoviesInteractorInput = SearchMoviesViewControllerDelegate

class SearchMoviesInteractor: SearchMoviesInteractorInput, SearchMoviesDataStore {
   
    var presenter: SearchMoviesinteractorDelegate?
    var worker: SearchMoviesWorker?
    var items: SearchMovies.Models.SearchMovieResponseModel?
    var movies: [SearchMovies.Models.SearchMovieResult] = []
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
            
            guard let selfs = self else { return }
            
            switch response {
            
            case .success(let item):
                
                selfs.items = item
                selfs.totlaResults = item.totalResults ?? 0
                selfs.movies.append(contentsOf: item.results)
                selfs.presenter?.presentMovies(response: selfs.movies, totalResult: selfs.totlaResults)
                
            case .failure(let error):
                self?.presenter?.presentError(with: error.description)
            }
        }
    }
    
    func sortItemBy(_ sortType: SortType) {
        
        guard !movies.isEmpty else { return }
        
        switch sortType {
        case .ReleaseDate:
            self.movies = movies.sorted(by: { ($0.releaseDate?.justYear ?? "") > ($1.releaseDate?.justYear ?? "")})
            self.presenter?.presentMovies(response: self.movies, totalResult: self.totlaResults)
        case .Title:
            self.movies = movies.sorted(by: { ($0.title ?? "") < ($1.title ?? "")})
            self.presenter?.presentMovies(response: self.movies, totalResult: self.totlaResults)
        }
    }
}
