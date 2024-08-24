//
//  ViewModel.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/21/24.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    @Published var favorites: [NearEarthObject] = []
    @Published var feed: [NearEarthObject] = []
    @Published var showingError = false
    @Published var date: Date = .now {
        didSet {
            feed.removeAll()
            Task { await populateFeed() }
        }
    }
    @Published var error: APIError? {
        didSet {
            showingError = true
        }
    }
    
    func populateFeed() async {
        do {
            let asteroids = try await service.fetchFeed(for: date)
            feed.append(contentsOf: asteroids)
        } catch let error as APIError {
            self.error = error
        } catch {
            self.error = .unknown
        }
    }
    
    func fetchAsteroid(id: String) async -> NearEarthObject? {
        do {
            return try await service.lookupNEO(with: id)
        } catch let error as APIError {
            self.error = error
        } catch {
            self.error = .unknown
        }
        return nil
    }
    
    func fetchFavorites(favorites: [String]) async -> [NearEarthObject] {
        await withTaskGroup(of: NearEarthObject?.self) { taskGroup in
            for id in favorites {
                taskGroup.addTask { await self.fetchAsteroid(id: id) }
            }
            
            var favorites: [NearEarthObject] = []
            
            for await asteroid in taskGroup {
                if let asteroid = asteroid {
                    favorites.append(asteroid)
                }
            }
            return favorites
        }   
    }
}
