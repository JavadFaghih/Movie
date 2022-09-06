//
//  MovieDetailsPresenter.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol MovieDetailsPresenterDelegate: AnyObject {
 
    func displayItemList(viewModel: MovieDetails.Models.ViewModel)
}

typealias MovieDetailsPresenterInput = MovieDetailsinteractorDelegate

class MovieDetailsPresenter: MovieDetailsPresenterInput {
 
    weak var viewController: MovieDetailsPresenterDelegate?
  
  // MARK: Do something
  func presentSomething(response: MovieDetails.Models.Response) {
  
      let viewModel = MovieDetails.Models.ViewModel()
    viewController?.displayItemList(viewModel: viewModel)
  }
}
