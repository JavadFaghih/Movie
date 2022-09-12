//
//  MovieDetailsRouter.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

@objc protocol MovieDetailsRoutingLogic {
}

protocol MovieDetailsDataPassing {

    var dataStore: MovieDetailsDataStore? { get }
}

class MovieDetailsRouter: NSObject, MovieDetailsRoutingLogic, MovieDetailsDataPassing {

    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
}
