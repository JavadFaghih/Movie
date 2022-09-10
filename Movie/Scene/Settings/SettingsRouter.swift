//
//  SettingsRouter.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol SettingsRoutingLogic {

    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SettingsDataPassing {

    var dataStore: SettingsDataStore? { get }
}

class SettingsRouter: NSObject, SettingsRoutingLogic, SettingsDataPassing {

    weak var viewController: SettingsViewController?
    var dataStore: SettingsDataStore?
    private  let storyboard = UIStoryboard(name: "Main", bundle: nil)

    
  // MARK: Routing
  //func routeToSomewhere(segue: UIStoryboardSegue?) {
  
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }


  // MARK: Navigation
  //func navigateToSomewhere(source: SettingsViewController, destination: SomewhereViewController) {
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
    
  //func passDataToSomewhere(source: SettingsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
