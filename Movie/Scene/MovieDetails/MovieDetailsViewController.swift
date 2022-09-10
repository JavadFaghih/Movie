//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.

import UIKit

protocol MovieDetailsViewControllerDelegate {

    func viewDidload()
}

typealias MovieDetailsViewControllerInput = MovieDetailsPresenterDelegate

class MovieDetailsViewController: UIViewController {
 
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDetailsLabel: UITextView!
    
    
    var interactor: MovieDetailsViewControllerDelegate?
    var router: (NSObjectProtocol & MovieDetailsRoutingLogic & MovieDetailsDataPassing)?

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
    let interactor = MovieDetailsInteractor()
    let presenter = MovieDetailsPresenter()
    let router = MovieDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
      if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  
      interactor?.viewDidload()
  }
}

     //MARK: - Presenter Delegate
extension MovieDetailsViewController: MovieDetailsViewControllerInput {
   
    func displayItemList(viewModel: MovieDetails.Models.ViewModel) {
        movieDetailsLabel.text = viewModel.title
        movieImageView.image = UIImage(data: viewModel.image!)
        
    }
}

