//
//  SearchMoviesPresenter.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SearchMoviesPresenterDelegate: AnyObject {
 
    func displayItemList(viewModel: [SearchMovies.Models.SearchViewModel])
}

typealias SearchMoviesPresenterInput = SearchMoviesinteractorDelegate

class SearchMoviesPresenter: SearchMoviesPresenterInput {

    weak var viewController: SearchMoviesPresenterDelegate?
  
  // MARK: Do something
    func presentMovies(response: [SearchMovieResult]?) {
        
        if let displayModel = response?.map({ $0.convertToDisplayableModel() }) {
        
        self.viewController?.displayItemList(viewModel: displayModel)
        }
    }
}
