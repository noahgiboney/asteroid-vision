//
//  AsteroidListViewModel.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/21/24.
//

import Foundation

class ViewModel: ObservableObject {
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    @Published var asteroids: [NearEarthObject] = []
    @Published var error: APIError?
    
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
    
    
}
