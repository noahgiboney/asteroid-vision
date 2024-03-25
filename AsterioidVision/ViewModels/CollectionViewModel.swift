//
//  CollectionViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import Foundation

extension CollectionView {
    
    @Observable
    class ViewModel {
	
	var collection: [CollectionNearEarthObject] = []
	
	var response: CollectionResponse?
	
	init () {
	   loadCollection()
	}
	
	func loadCollection() {
	    Task {
		response = try await NetworkService.shared.fetchAsteroidCollection(page: 1, size: 20)
		
		if let response {
		    collection = response.nearEarthObjects.filter({ asteroid in
			!asteroid.isPotentiallyHazardousAsteroid
		    })
		}
	    }
	}
    }
}