//
//  SettingsInteractor.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SettingsinteractorDelegate {

    func presentSomething(response: Settings.Models.Response)
}

protocol SettingsDataStore {
  //var name: String { get set }
}

typealias SettingsInteractorInput = SettingsViewControllerDelegate

class SettingsInteractor: SettingsInteractorInput, SettingsDataStore {

    var presenter: SettingsinteractorDelegate?
    var worker: SettingsWorker?
  //var name: String = ""
  
  // MARK: Do something
    func viewDidload() {
        
    }
    
    func changeUserInterfaceMode() {
        
    }
}
