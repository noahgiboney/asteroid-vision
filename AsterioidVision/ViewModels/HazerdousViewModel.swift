//
//  HazerdousViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

extension HazerdousView {
    
    @Observable
    class ViewModel {
	
	var hazards: [CollectionNearEarthObject] = []
	
	var response: CollectionResponse?
	
	var page = 0
	
	init() {
	    loadHazards()
	}
	
	func handleRefresh() {
	    page = 0
	    hazards.removeAll()
	    loadHazards()
	}
	
	func loadHazards() {
	    Task {
		page += 1
		response = try await NetworkService.shared.fetchAsteroidCollection(page: page)
		
		if let response {
		    hazards.append(contentsOf: response.nearEarthObjects.filter({ asteroid in
			asteroid.isPotentiallyHazardousAsteroid
		    }))
		}
	    }
	}
    }
}
