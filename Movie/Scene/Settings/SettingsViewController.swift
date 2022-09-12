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
    private var isDarkMode: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKey.isDarkMode.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.isDarkMode.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
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
    router.viewController = viewController
    router.dataStore = interactor
  }

    override func loadView() {
        super.loadView()
        tableView.tableFooterView = UIView()
    }
    
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
      interactor?.viewDidload()
      
  }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: SettingsTableViewCell.resuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: SettingsTableViewCell.resuseIdentifier)
        tableView.register(UINib(nibName: LanguageTableViewCell.reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: LanguageTableViewCell.reuseIdentifier)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource, InterfaceModeDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.resuseIdentifier) as? SettingsTableViewCell else { return UITableViewCell() }
        guard tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.reuseIdentifier) is LanguageTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.darkModeSwitch.isOn = !isDarkMode
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func darkModeSwitchStateChanged(_ sender: UISwitch) {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        isDarkMode = !sender.isOn
    }
}
