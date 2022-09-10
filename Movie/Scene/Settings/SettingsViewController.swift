//
//  SettingsViewController.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.

import UIKit

protocol SettingsViewControllerDelegate {

    func viewDidload()
    func changeUserInterfaceMode()
}

typealias SettingsViewControllerInput = SettingsPresenterDelegate

class SettingsViewController: UIViewController {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: SettingsViewControllerDelegate?
    var router: (NSObjectProtocol & SettingsRoutingLogic & SettingsDataPassing)?

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
    let interactor = SettingsInteractor()
    let presenter = SettingsPresenter()
    let router = SettingsRouter()
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
    
    override func loadView() {
        super.loadView()
        tableView.tableFooterView = UIView()
      //  tableView.backgroundColor = .placeholderText
    }
    
  
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
      interactor?.viewDidload()
  }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: SettingsTableViewCell.resuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: SettingsTableViewCell.resuseIdentifier)
    }
}

     //MARK: - Presenter Delegate
extension SettingsViewController: SettingsViewControllerInput {
   
    func displayItemList(viewModel: Settings.Models.ViewModel) {
      //nameTextField.text = viewModel.name
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource, InterfaceModeDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.resuseIdentifier) as? SettingsTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func darkModeSwitchStateChanged(_ sender: UISwitch) {
        self.overrideUserInterfaceStyle = .light
    }
}
