//
//  SettingsInteractor.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SettingsinteractorDelegate {

}

protocol SettingsDataStore {
}

typealias SettingsInteractorInput = SettingsViewControllerDelegate

class SettingsInteractor: SettingsInteractorInput, SettingsDataStore {

    var presenter: SettingsinteractorDelegate?
  
  // MARK: Do something
    func viewDidload() {
        
    }
    
    func changeUserInterfaceMode() {
        
    }
}
