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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
