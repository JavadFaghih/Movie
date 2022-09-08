//
//  SearchMoviesViewController.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import Alamofire

protocol SearchMoviesViewControllerDelegate {

    func viewDidload()
}

typealias SearchMoviesViewControllerInput = SearchMoviesPresenterDelegate

class SearchMoviesViewController: UIViewController {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: SearchMoviesViewControllerDelegate?
    var router: (NSObjectProtocol & SearchMoviesRoutingLogic & SearchMoviesDataPassing)?
    var items: SearchMovieResponseModel!
    
    
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
      configureSearchController()
      configureTableView()
  }
    
    private func configureSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "search Movies"
        navigationItem.searchController = search
    }
    
    private func requestForSearchMovie(with word: String, page: Int = 1) {
        
        let baseURL = NetworkRequirment.baseURL.rawValue
        let searchMoviewEndPoint = Search.searchMovie.rawValue
        let apiKey = NetworkRequirment.apiKey.rawValue
        
        let requestURL = "\(baseURL)\(searchMoviewEndPoint)?api_key=\(apiKey)&language=en-US&query=\(word)&page=\(page)&include_adult=false"
        
       let urlString = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""


        print(urlString)
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
               
                let str = String(bytes: data, encoding: .utf8)
                print(str!)
                
                if  let model = try? JSONDecoder().decode(SearchMovieResponseModel.self, from: data) {
                    self.items = model
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: SearchTableViewCell.reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
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
        return items?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard  let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier) as? SearchTableViewCell else { return UITableViewCell() }
        cell.configureCell(title: items!.results![indexPath.row].title ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MovieDetailsViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension SearchMoviesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }

           requestForSearchMovie(with: text)
       }
}
