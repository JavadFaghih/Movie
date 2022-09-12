//
//  SearchMoviesPresenter.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SearchMoviesPresenterDelegate: AnyObject {
 
    func displayItemList(viewModel: [SearchMovies.Models.SearchViewModel], totalResults: String)
    func displayError(with descrptions: String)
}

typealias SearchMoviesPresenterInput = SearchMoviesinteractorDelegate

class SearchMoviesPresenter: SearchMoviesPresenterInput {

    weak var viewController: SearchMoviesPresenterDelegate?
  
    func presentMovies(response: [SearchMovies.Models.SearchMovieResult]?, totalResult: Int) {
        
        if let displayModel = response?.map({ $0.convertToDisplayableModel() }) {
        
        self.viewController?.displayItemList(viewModel: displayModel, totalResults: "total results is: \(totalResult)")
        }
    }
    func presentError(with description: String) {
        self.viewController?.displayError(with: description)
    }
}
