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
	
	private var page = 1
	
	init () {
	   loadCollection()
	}
	
	func handleRefresh() {
	    page = 0
	    collection.removeAll()
	    loadCollection()
	}
	
	func loadCollection() {
	    Task {
		response = try await NetworkService.shared.fetchAsteroidCollection(page: page)
		
		if let response {
		    collection.append(contentsOf: response.nearEarthObjects.filter({ asteroid in
			!asteroid.isPotentiallyHazardousAsteroid
		    }))
		}
	    }
	}
    }
}
