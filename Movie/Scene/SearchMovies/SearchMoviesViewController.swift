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
    func sortItemBy(_ sortType: SortType)
}

typealias SearchMoviesViewControllerInput = SearchMoviesPresenterDelegate

class SearchMoviesViewController: MasterViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    var interactor: SearchMoviesViewControllerDelegate?
    var router: (NSObjectProtocol & SearchMoviesRoutingLogic & SearchMoviesDataPassing)?
    var items: [SearchMovies.Models.SearchViewModel] = []
    var totalResults: String?
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
   
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.viewDidLoad()
        configureSearchController()
        configureTableView()
        configureSegmentControll()
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
    
    private func configureSegmentControll() {
        segmentControll.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
    }
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
       
        if sender.selectedSegmentIndex == 0 {
            interactor?.sortItemBy(.ReleaseDate)
        } else {
            interactor?.sortItemBy(.Title)
        }
    }
}

//MARK: - Presenter Delegate
extension SearchMoviesViewController: SearchMoviesViewControllerInput {
  
    func displayItemList(viewModel: [SearchMovies.Models.SearchViewModel], totalResults: String) {
        self.items = viewModel
        self.totalResults = totalResults
        tableView.reloadData()
    }
    
    func displayError(with descrptions: String) {
        self.items.removeAll()
        self.totalResults = nil
        self.tableView.reloadData()
        self.alert(title: "Oops!", subtitle: descrptions)
        
    }
}

extension SearchMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return totalResults
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.05
    }
}

extension SearchMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        interactor?.requestForSearchMovie(with: text)
    }
    
    
}

enum SortType {
    case ReleaseDate
    case Title
}
