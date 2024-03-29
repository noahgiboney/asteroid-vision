//
//  NetworkManager.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation
import Observation

@Observable
class NetworkService {
    
    enum APIError: Error {
	case server, url, data
    }
    
    private let key = "dHOF8WnJtWYZrknUvPJZRddyB7J7q537zUXdwodN"
    
    private init() {}
    
    var error: Error?
    
    var errorMessage: String?
    
    static let shared = NetworkService()
    
    func fetchAsteroidCollection(page: Int) async throws -> Response? {
	
	let url = "https://api.nasa.gov/neo/rest/v1/neo/browse?page=\(page)&size=20&api_key=\(key)"
	
	do {
	    
	    guard let endpoint = URL(string: url) else {
		throw APIError.url
	    }
	    
	    let (data, response) = try await URLSession.shared.data(from: endpoint)
	    
	    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
		throw APIError.server
	    }
	    
	    let decoder = JSONDecoder()
	    decoder.keyDecodingStrategy = .convertFromSnakeCase
	    
	    guard let decodedData = try? decoder.decode(Response.self, from: data) else {
		throw APIError.data
	    }
	    errorMessage = nil
	    return decodedData
	    
	}  catch APIError.url{
	    errorMessage = "Invalid URL. Please try again later."
	} catch APIError.server {
	    errorMessage = "There was an error with the server. Please try again later."
	} catch APIError.data{
	    errorMessage = "There was an error with the data. Please try again later."
	}
	return nil
    }
}
