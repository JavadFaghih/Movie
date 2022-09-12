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
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var orignialLanguageLabel: UILabel!
    @IBOutlet weak var posterImageView: CashableImageView!
    
    func configureCell(with model: SearchMovies.Models.SearchViewModel) {
        self.titleLabel.text = model.title
        self.originalTitleLabel.text = model.originalTitle
        self.releaseDateLabel.text = model.releaseDate
        self.orignialLanguageLabel.text = model.originalLanguage
        
        if let url = URL(string: model.posterImageURL) {
            self.posterImageView.loadImageWith(url: url)
        }
    }
}
