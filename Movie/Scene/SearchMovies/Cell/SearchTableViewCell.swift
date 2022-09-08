//
//  SearchTableViewCell.swift
//  Movie
//
//  Created by Javad on 08.09.22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "SearchTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    commenInit()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commenInit()
    }


    private func commenInit() {
        
        
        
        
        
    }
    
    func configureCell(title: String) {
        self.titleLabel.text = title
        
    }
    
}
