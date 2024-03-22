//
//  AsteroidDetailViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

extension AsteroidDetailView {
    
    @Observable
    class ViewModel {
	
	var networkManager = NetworkService()
	
	var allSightings: [CloseApproachData] = []
	
	var object: NearEarthObject?
	
	var isHazard = false
    
	var id = ""
	
	init(id: String) {
	    self.id = id
	    loadAsteroidSightings()
	}
	
	func loadAsteroidSightings () {
	    Task {
		object = try await networkManager.fetchAsteroidSightings(for: id)
	    }
	    
	    if let object {
		allSightings = object.closeApproachData
	    }
	    
	}
    }
    
}

