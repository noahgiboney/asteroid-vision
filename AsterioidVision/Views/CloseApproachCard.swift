//
//  CloseApproachCard.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CloseApproachCard: View { 
    
    @AppStorage("distance") var distanceSelection: Distance = .miles
    @AppStorage("speed") var speedSelection: Speed = .kmPerS
    @AppStorage("diameter") var diameterSelection: Diameter = .kilometers
    
    var entry: CloseApproachData
    
    var body: some View {
	VStack(alignment: .leading, spacing: 10) {
	    
	    VStack(alignment: .leading){
	        Text("Orbiting \(entry.orbitingBody)")
		    .font(.headline)
		
		Text(entry.date)
		    .font(.caption)
		
		Text("Epoch \(entry.epochDateCloseApproach)")
		    .font(.caption)
	    }
	    
	    Text(velocity)
	    
	    Text(missDistance)
	}
	.padding()
	.background(Color.gray.opacity(0.3))
	.clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CloseApproachCard(entry: CloseApproachData.example)
}

extension CloseApproachCard {
    
    var missDistance: String {
	switch distanceSelection {
	case .kilometers:
	    "Distace From Earth: " + entry.missDistance.kilometers.beforeDecimal + " km"
	case .miles:
	    "Distace From Earth: " + entry.missDistance.miles.beforeDecimal + " miles"
	case .lunar:
	    "Distace From Earth: " + entry.missDistance.lunar.beforeDecimal + " lunar distances"
	case .astronomical:
	    "Distace From Earth: " + entry.missDistance.astronomical + " au"
	}
    }
    
    var velocity: String {
	switch speedSelection {
	case .kmPerS:
	    "Traveling: " +
	    entry.relativeVelocity.kilometersPerSecond.beforeDecimal + " km/s"
	case .kmPerH:
	    "Traveling: " +
	    entry.relativeVelocity.kilometersPerHour.beforeDecimal + " km/hr"
	case .mph:
	    "Traveling: " +
	    entry.relativeVelocity.milesPerHour.beforeDecimal + " mph"
	}
    }
}
