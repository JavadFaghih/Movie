//
//  SettingsPresenter.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.
//

import UIKit

protocol SettingsPresenterDelegate: AnyObject {
 
    func displayItemList(viewModel: Settings.Models.ViewModel)
}

typealias SettingsPresenterInput = SettingsinteractorDelegate

class SettingsPresenter: SettingsPresenterInput {
 
    weak var viewController: SettingsPresenterDelegate?
  
  // MARK: Do something
  func presentSomething(response: Settings.Models.Response) {
  
      let viewModel = Settings.Models.ViewModel()
    viewController?.displayItemList(viewModel: viewModel)
  }
}
