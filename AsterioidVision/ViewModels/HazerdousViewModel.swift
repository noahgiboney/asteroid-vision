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
	
	init() {
	    loadHazards()
	}
	
	func loadHazards() {
	    Task {
		response = try await NetworkService.shared.fetchAsteroidCollection(page: 1, size: 20)
		
		if let response {
		    hazards = response.nearEarthObjects.filter({ asteroid in
			asteroid.isPotentiallyHazardousAsteroid
		    })
		}
	    }
	}
    }
}
