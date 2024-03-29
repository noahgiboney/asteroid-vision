//
//  HazerdousViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

extension AsteroidListView {
    
    enum AsteroidType {
	case hazard, nonHazard
    }
    
    @Observable
    class ViewModel {
	
	var asteroidCollection: [NearEarthObject] = []
	
	var response: Response?
	
	var searchTerm = ""
	
	var showingFilterSheet = false
	
	var isLoading = false
	
	var minVelocity = 0.0
	var minDiameter = 0.0
	var minMagnitude = 0.0
	
	private var page = 0
	
	init() {
	    isLoading = true
	    loadHazards()
	}
	
	func handleRefresh() {
	    page = 0
	    asteroidCollection.removeAll()
	    loadHazards()
	}
	
	func loadHazards() {
	    isLoading = true
	    Task {
		page += 1
		response = try await NetworkService.shared.fetchAsteroidCollection(page: page)
		
		if let response {
		    asteroidCollection.append(contentsOf: response.nearEarthObjects)
		    isLoading = false
		}
	    }
	}
    }
}
