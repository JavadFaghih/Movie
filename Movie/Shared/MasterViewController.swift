//
//  MasterViewController.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//

import UIKit

class MasterViewController: UIViewController {
    
    func alert(title: String, subtitle: String) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
        
    }
}
