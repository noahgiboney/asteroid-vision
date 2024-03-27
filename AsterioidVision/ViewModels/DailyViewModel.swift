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
	    loadNEO()
	}
	
	func loadNEO() {
	    
	    Task {
		response = try await NetworkService.shared.fetchNEO(for: date)
		
		if let response {
		    asteroids = response.nearEarthObjects.objects
		}
	    }
	}
	
    }
}
