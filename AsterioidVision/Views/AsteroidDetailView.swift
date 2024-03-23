//
//  AsteroidDetailView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import SwiftUI

struct AsteroidDetailView: View {
    
    var asteroid: NearEarthObject
    
    @State private var viewModel = ViewModel(id: "78978") 
    
    init(asteroid: NearEarthObject) {
	self.asteroid = asteroid
	_viewModel = State(wrappedValue: ViewModel(id: asteroid.id))
    }
    
    var body: some View {
	NavigationStack {
	    
	    List {
		Section("\(Date().shortDate) Approach Data"){
		    Text("\(viewModel.isHazard ? "HAZARDOUS" : "Non-Hazardous") Asteroid")
			.font(.headline)
			.foregroundStyle(viewModel.isHazard ? .red : .green)
		    Text("Miss Distance: ")
			.font(.headline) +
		    Text("\(asteroid.closeApproachData[0].missDistance.kilometers.beforeDecimal) km")
		    
		    Text("Relative Velocity: ")
			.font(.headline) +
		    Text(" \(asteroid.closeApproachData[0].relativeVelocity.kms)")
		    
		    Text("Estimated Diameter: ")
			.font(.headline) +
		    Text("\(asteroid.estimatedDiameter.diamter)")
		    
		    
		}
		.foregroundStyle(.white)
		.listRowBackground(Color.gray.opacity(0.3))
		
		Section("Close Approaches"){
		    ForEach(viewModel.allSightings, id: \.epochDateCloseApproach) { sighting in
			SightingRow(closeApproach: sighting)
		    }
		}
		.listRowBackground(Color.gray.opacity(0.3))
		.foregroundStyle(.white)
		.onAppear {
		    viewModel.isHazard = asteroid.isPotentiallyHazardousAsteroid
		}
		
	    }
	    
	    .scrollContentBackground(.hidden)
	    
	    
	    
	    .frame(maxWidth: .infinity, maxHeight: .infinity)
	    .navigationTitle(asteroid.name)
	    .navigationBarTitleTextColor(.white)
	    .background(Image("background"))
	}
    }
}

#Preview {
    AsteroidDetailView(asteroid: NearEarthObject.example)
}

