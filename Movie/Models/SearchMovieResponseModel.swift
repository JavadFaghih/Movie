//
//  SearchMovieResponseModel.swift
//  Movie
//
//  Created by Javad on 08.09.22.
//

import UIKit

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
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
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
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func convertToDisplayableModel() -> SearchMovies.Models.SearchViewModel {
        
        let model = SearchMovies.Models.SearchViewModel(title: title ?? "",
                                                        originalTitle: originalTitle ?? "",
                                                        originalLanguage: originalLanguage ?? "",
                                                        releaseDate: releaseDate ?? "",
                                                        posterImageURL: "\(baseURL)\(posterPath ?? "")")
        return model
        
    }
}

