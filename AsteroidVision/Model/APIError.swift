//
//  APIError.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/21/24.
//

import Foundation

enum APIError: LocalizedError {
    case server, url, data, unknown
    
    var errorDescription: String? {
        switch self {
        case .server:
            "Server Error"
        case .url:
            "URL Error"
        case .data:
            "Data Error"
        case .unknown:
            "Error"
        }
    }
    
    var failureReason: String {
        switch self {
        case .server:
            "An error occured on the server."
        case .url:
            "Error proccessing the url"
        case .data:
            "Error decoding the data."
        case .unknown:
            "An unknown error has occured."
        }
    }
}
