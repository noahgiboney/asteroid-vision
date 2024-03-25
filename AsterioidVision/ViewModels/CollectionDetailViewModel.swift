//
//  CollectionDetailViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import Foundation

extension CollectionDetailView {
    
    @Observable
    class ViewModel {
	
	var distance: Distance = .kilometers
	
	var speed: Speed = .kmPerS
	
	var diameter: Diameter = .kilometers
    }
}
