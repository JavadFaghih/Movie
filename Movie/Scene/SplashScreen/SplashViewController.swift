//
//  SplashViewController.swift
//  Movie
//
//  Created by javad faghih on 9/9/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.

import UIKit

protocol SplashViewControllerDelegate {
    func viewDidload()
}

class SplashViewController: UIViewController {
 
    var interactor: SplashViewControllerDelegate?
    var router: (SplashRoutingLogic)?

  // MARK: Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
 
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  private func setup() {
  
    let viewController = self
    let interactor = SplashInteractor()
    let router = SplashRouter()
    viewController.interactor = interactor
    viewController.router = router
    router.viewController = viewController
  }
  
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  
      interactor?.viewDidload()
  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        router?.changeRoot()
    }
}
