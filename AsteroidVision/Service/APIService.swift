//
//  APIService.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/21/24.
//

import Foundation

class APIService {
    var decoder = JSONDecoder()
    
    init() {
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchFeed(for date: Date, page: Int) async throws -> [NearEarthObject] {
        guard let url = URL(string: feedUrl(date: date, page: page)) else { throw APIError.url }
        
        let data = try await fetchData(for: url)
        
        do {
            let response = try decoder.decode(FeedResponse.self, from: data)
            
            if let asteroids = response.nearEarthObjects[date.formatted] {
                return asteroids
            } else {
                throw APIError.data
            }
        } catch {
            throw APIError.data
        }
    }
    
    func lookupNEO(with id: String) async throws -> NearEarthObject {
        guard let url = URL(string: "\(urlString)/neo/\(id)?\(apiKeyString)") else { throw APIError.url }
        
        let data = try await fetchData(for: url)
        
        do {
            return try decoder.decode(NearEarthObject.self, from: data)
        } catch {
            throw APIError.data
        }
    }
    
    private func fetchData(for url: URL) async throws -> Data {
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw APIError.server}
        return data
    }
    
    private func feedUrl(date: Date, page: Int) -> String {
        let dateString = date.formatted
        
        return "\(urlString)/feed?start_date=\(dateString)?page=\(page)&size=5&\(apiKeyString)"
    }
}
