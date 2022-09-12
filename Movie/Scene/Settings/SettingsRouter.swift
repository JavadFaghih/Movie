//
//  SettingsRouter.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

@objc protocol SettingsRoutingLogic {
}

protocol SettingsDataPassing {

    var dataStore: SettingsDataStore? { get }
}

class SettingsRouter: NSObject, SettingsRoutingLogic, SettingsDataPassing {

    weak var viewController: SettingsViewController?
    var dataStore: SettingsDataStore?

}
