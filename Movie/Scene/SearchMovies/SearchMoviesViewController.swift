//
//  SearchMoviesViewController.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.

import UIKit
import Alamofire

protocol SearchMoviesViewControllerDelegate {
    func viewDidLoad()
    func requestForSearchMovie(with: String)
    func requestForNexPageIfNedded()
}

typealias SearchMoviesViewControllerInput = SearchMoviesPresenterDelegate

class SearchMoviesViewController: MasterViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: SearchMoviesViewControllerDelegate?
    var router: (NSObjectProtocol & SearchMoviesRoutingLogic & SearchMoviesDataPassing)?
    var items: [SearchMovies.Models.SearchViewModel] = []
    
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
        
        interactor?.viewDidLoad()
        configureSearchController()
        configureTableView()
    }
    
    private func configureSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "search Movies"
        navigationItem.searchController = search
        
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: SearchTableViewCell.reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        
    }
}

//MARK: - Presenter Delegate
extension SearchMoviesViewController: SearchMoviesViewControllerInput {
    
    func displayError(with descrptions: String) {
        self.items.removeAll()
        self.tableView.reloadData()
        self.alert(title: "Oops!", subtitle: descrptions)
        
    }
    
    func displayItemList(viewModel: [SearchMovies.Models.SearchViewModel]) {
        self.items = viewModel
        tableView.reloadData()
    }
}

extension SearchMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier) as? SearchTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToDetailsMovie(with: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.15
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row + 2) == items.count {
            interactor?.requestForNexPageIfNedded()
        }
    }
}

extension SearchMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        interactor?.requestForSearchMovie(with: text)
    }
    
    
}
