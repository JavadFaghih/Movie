//
//  LanguageTableViewCell.swift
//  Movie
//
//  Created by Javad on 12.09.22.
//

import UIKit

class LanguageTableViewCell: MasterTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseIdentifier: String = "LanguageTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
