//
//  DailyViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/22/24.
//

import Foundation

extension DailyView{
    
    @Observable
    class ViewModel {
	
	var asteroids: [NearEarthObject] = []
	
	var response: Response?
	
	var date: Date = .now
	
	init() {
	    loadAsteroids()
	}
	
	func loadAsteroids() {
	    
	    Task {
		response = try await NetworkService.shared.fetchAsteroids()
		
		if let response {
		    asteroids = response.nearEarthObjects.objects
		}
	    }
	}
	
    }
}
