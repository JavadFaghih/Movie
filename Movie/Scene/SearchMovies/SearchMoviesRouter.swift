//
//  SearchMoviesRouter.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol SearchMoviesRoutingLogic {

    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SearchMoviesDataPassing {

    var dataStore: SearchMoviesDataStore? { get }
}

class SearchMoviesRouter: NSObject, SearchMoviesRoutingLogic, SearchMoviesDataPassing {

    weak var viewController: SearchMoviesViewController?
    var dataStore: SearchMoviesDataStore?
    private  let storyboard = UIStoryboard(name: "Main", bundle: nil)

    
  // MARK: Routing
  //func routeToSomewhere(segue: UIStoryboardSegue?) {
  
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }


  // MARK: Navigation
  //func navigateToSomewhere(source: SearchMoviesViewController, destination: SomewhereViewController) {
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
    
  //func passDataToSomewhere(source: SearchMoviesDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
