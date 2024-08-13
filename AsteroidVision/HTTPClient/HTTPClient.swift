//
//  HTTPClient.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation
import Observation



enum APIError: Error {
    case server, url, data
}

struct HTTPClient {
    private let key = "dHOF8WnJtWYZrknUvPJZRddyB7J7q537zUXdwodN"
    
    let decoder = JSONDecoder()
    
    
    func fetchAsteroidCollection(page: Int) async throws -> Response? {
        let url = "https://api.nasa.gov/neo/rest/v1/neo/browse?page=\(page)&size=20&api_key=\(key)"
        
        guard let endpoint = URL(string: url) else { throw APIError.url }
        
        let (data, response) = try await URLSession.shared.data(from: endpoint)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.server }
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let decodedData = try? decoder.decode(Response.self, from: data) else { throw APIError.data }
        return decodedData
    }
    
    func fetchAsteroid(id: String) async throws -> NearEarthObject {
        let url = "https://api.nasa.gov/neo/rest/v1/neo/\(id)?api_key=\(key)"
        
        guard let endpoint = URL(string: url) else { throw APIError.url }
        
        let (data, response) = try await URLSession.shared.data(from: endpoint)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.server}
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let asteroid = try? decoder.decode(NearEarthObject.self, from: data) else { throw APIError.data }
        return asteroid
    }
}
