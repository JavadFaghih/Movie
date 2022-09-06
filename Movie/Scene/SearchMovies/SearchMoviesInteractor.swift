//
//  SearchMoviesInteractor.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SearchMoviesinteractorDelegate {

    func presentSomething(response: SearchMovies.Models.Response)
}

protocol SearchMoviesDataStore {
  //var name: String { get set }
}

typealias SearchMoviesInteractorInput = SearchMoviesViewControllerDelegate

class SearchMoviesInteractor: SearchMoviesInteractorInput, SearchMoviesDataStore {

    var presenter: SearchMoviesinteractorDelegate?
    var worker: SearchMoviesWorker?
  //var name: String = ""
  
  // MARK: Do something
    func viewDidload() {
        
    }
}
