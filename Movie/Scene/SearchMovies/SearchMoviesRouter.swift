//
//  SearchMoviesRouter.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol SearchMoviesRoutingLogic {

    func navigateToDetailsMovie(with index: Int)
}

protocol SearchMoviesDataPassing {

    var dataStore: SearchMoviesDataStore? { get }
}

class SearchMoviesRouter: NSObject, SearchMoviesRoutingLogic, SearchMoviesDataPassing {
   
    weak var viewController: SearchMoviesViewController?
    var dataStore: SearchMoviesDataStore?
    private  let storyboard = UIStoryboard(name: "Main", bundle: nil)

  // MARK: Routing
    func navigateToDetailsMovie(with index: Int) {
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomewhere(source: dataStore!, destination: &destinationDS, index: index)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
 
  // MARK: Navigation
  func navigateToSomewhere(source: SearchMoviesViewController, destination: MovieDetailsViewController) {
    source.show(destination, sender: nil)
  }
  
 //  MARK: Passig data
    func passDataToSomewhere(source: SearchMoviesDataStore, destination: inout MovieDetailsDataStore, index: Int)  {
        destination.id = source.movies[index].id ?? 0
  }
}
