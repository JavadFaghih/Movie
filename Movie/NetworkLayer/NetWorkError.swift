//
//  NetWorkError.swift
//  Movie
//
//  Created by javad faghih on 9/10/22.
//

import Foundation

enum NetworkResponseType<T>  {
    case success(data: T)
    case failure(error: NetworkErrorType)
}

enum NetworkErrorType: Error {
    case timeOut
    case noData
    case failed
    
    var description: String {
        switch self {
        
        case .timeOut:
            return "time out error"
        case .noData:
            return "nothing was found"
        case .failed:
            return "failed, please try again later"
        }
    }
}
