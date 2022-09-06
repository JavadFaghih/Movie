//
//  SearchMoviesViewController.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol SearchMoviesViewControllerDelegate {

    func viewDidload()
}

typealias SearchMoviesViewControllerInput = SearchMoviesPresenterDelegate

class SearchMoviesViewController: UIViewController {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: SearchMoviesViewControllerDelegate?
    var router: (NSObjectProtocol & SearchMoviesRoutingLogic & SearchMoviesDataPassing)?

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
    let interactor = SearchMoviesInteractor()
    let presenter = SearchMoviesPresenter()
    let router = SearchMoviesRouter()
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
extension SearchMoviesViewController: SearchMoviesViewControllerInput {
   
    func displayItemList(viewModel: SearchMovies.Models.ViewModel) {
      //nameTextField.text = viewModel.name
        
    }
}

extension SearchMoviesViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MovieDetailsViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
