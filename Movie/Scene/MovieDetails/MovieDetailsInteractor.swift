//
//  MovieDetailsInteractor.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol MovieDetailsinteractorDelegate {

    func presentMovieDetails(response: MovieDetails.Models.ViewModel)
    func presentError(message: String)
}

protocol MovieDetailsDataStore {
    var id: Int! { get set }
    var details: MovieDetails.Models.MovieDetailsResponse? { get }
}

typealias MovieDetailsInteractorInput = MovieDetailsViewControllerDelegate

class MovieDetailsInteractor: MovieDetailsInteractorInput, MovieDetailsDataStore {
    
    var details: MovieDetails.Models.MovieDetailsResponse?
    var id: Int!
    var presenter: MovieDetailsinteractorDelegate?
    var worker: MovieDetailsWorker?
    var baseURL: String {
        get {
            
            let defaults = UserDefaults.standard
            let data = defaults.data(forKey: UserDefaultsKey.apiConfiguration.rawValue) ?? Data()
            
            if  let configuration = try? JSONDecoder().decode(Splash.GetAPIConfigurationResponseModel.self, from: data) {
                
                return (configuration.images?.secureBaseURL ?? "https://image.tmdb.org/t/p/") + (configuration.images?.posterSizes?.last ?? "w92")
                
            }
            return "https://image.tmdb.org/t/p/w92"
        }
    }
    var image: Data?
   
    
    // MARK: Do something
    func viewDidload() {
        
        worker = MovieDetailsWorker()
        getMovieDetails(with: id)
    }
    
    private func getMovieDetails(with id: Int) {
   
        self.worker?.getMovieDetails(with: id) { [weak self] result in
            
            switch result {
            
            case .success(let object):
                self?.details = object
                self?.getImage()
            case .failure(let error):
                self?.presenter?.presentError(message: error.description)
            }
            
        }
    }
    
    
    private func releaseDetails(with details: MovieDetails.Models.MovieDetailsResponse) {
        
        
        
       
        
       
        let viewModel = MovieDetails.Models.ViewModel(overView: details.overview ?? "---",
                                                      image: image,
                                                      title: details.title ?? "---",
                                                      budget: String(details.budget ?? 0),
                                                      status: details.status ?? "---",
                                                      vote: String(details.voteAverage ?? 0),
                                                      popularity: String(details.popularity ?? 0),
                                                      imdb: details.imdbID ?? "---")
  
        presenter?.presentMovieDetails(response: viewModel)

    }
    
    
    private func getImage() {
        
            let url = self.baseURL + (self.details!.backdropPath ?? "")
            
            self.worker?.loadImage(url: url) { data in
                self.image = data
                self.releaseDetails(with: self.details!)
            }
        }
    }
