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
