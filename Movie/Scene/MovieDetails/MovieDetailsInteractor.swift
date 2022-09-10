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
}

protocol MovieDetailsDataStore {
    var id: Int! { get set }
}

typealias MovieDetailsInteractorInput = MovieDetailsViewControllerDelegate

class MovieDetailsInteractor: MovieDetailsInteractorInput, MovieDetailsDataStore {
  
    var id: Int!
    var presenter: MovieDetailsinteractorDelegate?
    var worker: MovieDetailsWorker?
  
  // MARK: Do something
    func viewDidload() {
        
        worker = MovieDetailsWorker()
      //  downloadImage()
        getMovieDetails(with: id)
    }
    
//    private func downloadImage() {
//        guard let model = response else { return }
//        let url = model.baseUrl + model.backdropPath
//
//        worker?.loadImage(url: url) { [weak self] image in
//
//            self?.presenter?.presentMovieDetails(response: MovieDetails.Models.ViewModel(title: model.details,
//                                                                                   image: image))
//        }
//    }
    
    private func getMovieDetails(with id: Int) {
        self.worker?.getMovieDetails(with: id) { result in
            
            switch result {
            
            case .success(let object):
                print(object)
            case .failure(let error):
                switch error {
                
                case .timeOut:
                    break
                case .noData:
                    break
                case .failed:
                    break
                }
            }
        }
    }
}
