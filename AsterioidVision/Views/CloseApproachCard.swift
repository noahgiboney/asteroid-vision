//
//  CloseApproachCard.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CloseApproachCard: View {
    
    var entry: CloseApproachData
    
    var body: some View {
	VStack(alignment: .leading, spacing: 10) {
	    
	    VStack(alignment: .leading){
	        Text("Orbiting \(entry.orbitingBody)")
		    .font(.headline)
		
		Text(entry.date)
		    .font(.caption)
	    }
	    
	    Text("Traveling \(entry.relativeVelocity.kms)")
	    
	    Text("Missed by \(entry.missDistance.km)")
	}
	.padding()
	.background(.ultraThinMaterial)
	.clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CloseApproachCard(entry: CloseApproachData.example)
}
