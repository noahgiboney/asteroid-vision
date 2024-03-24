//
//  NasaError.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

enum APIError: Error {
    
    case server
    case url
    case data
    case unkown(Error)
    
    var message: String? {
	switch self {
	case .server: "There was an error with the server. Please try again later."
	case .url:
	    ""
	case .data:
	    "The Asteroid data is invalid. Please try again later."
	    
	case .unkown(let error):
	    "\(error.localizedDescription)"
	}
    }
}
