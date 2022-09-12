//
//  MasterTableViewCell.swift
//  Movie
//
//  Created by Javad on 12.09.22.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .tableCellBackground
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
        
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
}
