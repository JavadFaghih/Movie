//
//  SplashModels.swift
//  Movie
//
//  Created by javad faghih on 9/9/22.
//  Copyright (c) 2022 Javad Faghih. All rights reserved.


import UIKit

enum Splash {
 
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

}
