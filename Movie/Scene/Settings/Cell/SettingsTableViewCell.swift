//
//  SettingsTableViewCell.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//

import UIKit

protocol InterfaceModeDelegate: AnyObject {
    
    func darkModeSwitchStateChanged(_ sender: UISwitch)
}

class SettingsTableViewCell: MasterTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    static let resuseIdentifier: String = "SettingsTableViewCell"
    
    weak var delegate: InterfaceModeDelegate?
    
    @IBAction func darkModeSwitchchanged(_ sender: UISwitch) {
        
        self.delegate?.darkModeSwitchStateChanged(sender)
    }
    
}
