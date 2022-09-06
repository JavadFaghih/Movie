//
//  MovieDetailsInteractor.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol MovieDetailsinteractorDelegate {

    func presentSomething(response: MovieDetails.Models.Response)
}

protocol MovieDetailsDataStore {
  //var name: String { get set }
}

typealias MovieDetailsInteractorInput = MovieDetailsViewControllerDelegate

class MovieDetailsInteractor: MovieDetailsInteractorInput, MovieDetailsDataStore {

    var presenter: MovieDetailsinteractorDelegate?
    var worker: MovieDetailsWorker?
  //var name: String = ""
  
  // MARK: Do something
    func viewDidload() {
        
    }
}
