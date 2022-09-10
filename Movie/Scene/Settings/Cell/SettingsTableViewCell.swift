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

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    static let resuseIdentifier: String = "SettingsTableViewCell"
    
    weak var delegate: InterfaceModeDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 8
        self.clipsToBounds = true

    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
        
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }

    
    @IBAction func darkModeSwitchchanged(_ sender: UISwitch) {
        
        self.delegate?.darkModeSwitchStateChanged(sender)
    }
    
}
