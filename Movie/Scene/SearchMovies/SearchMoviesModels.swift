//
//  SearchMoviesModels.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.


import UIKit

enum SearchMovies {
 
    // MARK: Use cases
  enum Models {
   
      struct Request {
   
    
    }
      struct Response {
   
    
    }
   
      struct SearchViewModel {
        let title: String
        let originalTitle: String
        let originalLanguage: String
        let releaseDate: String
        let posterImageURL: String
        let overView: String
      }
      
  }
}
