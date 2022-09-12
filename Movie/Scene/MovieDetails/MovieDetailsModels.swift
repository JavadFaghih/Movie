//
//  MovieDetailsModels.swift
//  Movie
//
//  Created by javad faghih on 9/6/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.


import UIKit

enum MovieDetails {
 
    // MARK: Use cases
  enum Models {
   
    struct MovieDetailsResponse: Codable {
        let backdropPath: String?
        let budget: Int?
        let genres: [Genre]?
        let homepage: String?
        let id: Int?
        let imdbID, originalLanguage, originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let releaseDate: String?
        let revenue: Int?
        let spokenLanguages: [SpokenLanguage]?
        let status, title: String?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case budget, genres, homepage, id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case revenue
            case spokenLanguages = "spoken_languages"
            case status, title
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

    // MARK: - BelongsToCollection
    struct BelongsToCollection: Codable {
        let id: Int?
        let name, posterPath, backdropPath: String?

        enum CodingKeys: String, CodingKey {
            case id, name
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
        }
    }

    // MARK: - Genre
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }

    // MARK: - SpokenLanguage
    struct SpokenLanguage: Codable {
        let englishName, iso639_1, name: String?

        enum CodingKeys: String, CodingKey {
            case englishName = "english_name"
            case iso639_1 = "iso_639_1"
            case name
        }
    }

      struct ViewModel {
        let overView: String
        let image: Data?
        let title: String
        let budget: String
        let status: String
        let vote: String
        let popularity: String
        let imdb: String
        
      }
      
  }
}
