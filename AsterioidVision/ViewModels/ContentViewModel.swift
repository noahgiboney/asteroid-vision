//
//  ContentViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

extension ContentView {
    
    @Observable
    class ViewModel {
	
	var networkService = NetworkService()
	
	var asteroids: [NearEarthObject] = []
	
	var response: Response?
	
	var date: Date = .now
	
	var hazardousAsteroids: [NearEarthObject] {
	    return asteroids.filter { asteroid in
		asteroid.isPotentiallyHazardousAsteroid
	    }
	}
	
	var nonHazardousAsteroids: [NearEarthObject] {
	    return asteroids.filter { asteroid in
		!asteroid.isPotentiallyHazardousAsteroid
	    }
	}
	
	
	init() {
	    loadAsteroids()
	}
	
	func loadAsteroids() {
	    
	    Task {
		response = try await networkService.fetchAsteroids()
		
		if let response {
		    asteroids = response.nearEarthObjects.objects
		}
	    }
	}
    }
}
