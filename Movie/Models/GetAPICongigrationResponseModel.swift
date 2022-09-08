//
//  GetAPICongigrationResponseModel.swift
//  Movie
//
//  Created by Javad on 08.09.22.
//

import Foundation

struct GetAPIConfigurationResponseModel: Codable {
    let images: ImagesConfigration?
    let changeKeys: [String]?

    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

// MARK: - Images
struct ImagesConfigration: Codable {
    let baseURL: String?
    let secureBaseURL: String?
    let backdropSizes, logoSizes, posterSizes, profileSizes: [String]?
    let stillSizes: [String]?

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
