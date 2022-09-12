//
//  SettingsPresenter.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SettingsPresenterDelegate: AnyObject {
 
}

typealias SettingsPresenterInput = SettingsinteractorDelegate

class SettingsPresenter: SettingsPresenterInput {
 
    weak var viewController: SettingsPresenterDelegate?
    
}
