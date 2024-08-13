//
//  AsteroidStore.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/8/24.
//

import Combine
import SwiftUI

enum AsteroidType {
    case hazard, nonHazard
}

@Observable
class AsteroidStore {
    private let client = HTTPClient()
    private var page = 0
    
    var hazards: [NearEarthObject] = []
    var response: Response?
    var isLoading = true
    var errorMessage: String?
    var cancellables = Set<AnyCancellable>()
    
    func handleRefresh() {
        page = 0
        hazards.removeAll()
        Task { try await loadHazards() }
    }
    
    func loadHazards() async throws {
        do {
            isLoading = true
            page += 1
            response = try await client.fetchAsteroidCollection(page: page)
            
            if let asteroids = response?.nearEarthObjects {
                let hazardousAsteroids = asteroids.filter { $0.isPotentiallyHazardousAsteroid }
                hazards.append(contentsOf: hazardousAsteroids)
                isLoading = false
            }
        } catch APIError.url {
            errorMessage = "Invalid URL. Please try again later."
        } catch APIError.server {
            errorMessage = "There was an error with the server. Please try again later."
        } catch APIError.data {
            errorMessage = "There was an error with the data. Please try again later."
        }
    }
    
    func fetchAsteroid(_ id: String) async throws -> NearEarthObject? {
        do {
            return try await client.fetchAsteroid(id: id)
        } catch APIError.url {
            errorMessage = "Invalid URL. Please try again later."
        } catch APIError.server {
            errorMessage = "There was an error with the server. Please try again later."
        } catch APIError.data {
            errorMessage = "There was an error with the data. Please try again later."
        }
        return nil
    }
}
