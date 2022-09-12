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
   
      struct SearchMovieResponseModel: Codable {
          let page: Int?
          let results: [SearchMovieResult]
          let totalPages, totalResults: Int?

          enum CodingKeys: String, CodingKey {
              case page, results
              case totalPages = "total_pages"
              case totalResults = "total_results"
          }
      }

      // MARK: - Result
      struct SearchMovieResult: Codable {
          let backdropPath: String?
          let id: Int?
          let originalLanguage: String?
          let originalTitle, overview: String?
          let popularity: Double?
          let posterPath, releaseDate, title: String?
          let voteAverage: Double?
          let voteCount: Int?
          var baseURL: String {
              get {
                  
                  let defaults = UserDefaults.standard
                  let data = defaults.data(forKey: UserDefaultsKey.apiConfiguration.rawValue) ?? Data()
                  
                  if  let configuration = try? JSONDecoder().decode(Splash.GetAPIConfigurationResponseModel.self, from: data) {
                      
                      return (configuration.images?.secureBaseURL ?? "https://image.tmdb.org/t/p/") + (configuration.images?.posterSizes?.first ?? "w92")
                      
                  }
                  return "https://image.tmdb.org/t/p/w92"
              }
          }
          
          enum CodingKeys: String, CodingKey {
              case backdropPath = "backdrop_path"
              case id
              case originalLanguage = "original_language"
              case originalTitle = "original_title"
              case overview, popularity
              case posterPath = "poster_path"
              case releaseDate = "release_date"
              case title
              case voteAverage = "vote_average"
              case voteCount = "vote_count"
          }
          
          func convertToDisplayableModel() -> SearchMovies.Models.SearchViewModel {
              
              let model = SearchMovies.Models.SearchViewModel(title: title ?? "",
                                                              originalTitle: originalTitle ?? "",
                                                              originalLanguage: originalLanguage ?? "",
                                                              releaseDate: releaseDate?.justYear ?? "",
                                                              posterImageURL: "\(baseURL)\(posterPath ?? "")", overView: overview ?? "")
              return model
              
          }
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
