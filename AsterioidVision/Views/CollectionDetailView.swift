//
//  CollectionDetailView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CollectionDetailView: View {
    
    @AppStorage("Unit") var unitSelection: Distance = .miles
    @State private var viewModel = ViewModel()
    
    var asteroid: CollectionNearEarthObject
    
    var body: some View {
	
	NavigationStack {
	    
	    List {
		
		VStack{
		    MySceneView(model: "asteroid.usdz", rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
			.frame(height: 100)
			.padding()
		}
		.listRowSeparator(.hidden)
		
		HStack(alignment: .center){
		    Spacer()
		    Text("\(asteroid.isPotentiallyHazardousAsteroid ? "HAZARDOUS" : "Non-Hazardous")")
			.font(.headline)
			.foregroundStyle(asteroid.isPotentiallyHazardousAsteroid ? .red : .black)
		    Spacer()
		}
		.listRowSeparator(.hidden)
		
		Section(asteroid.name){
		    
		    Text(missDistance)
		    
		    Text("Relative Velocity: ")
		    +
		    Text(" \(asteroid.closeApproachData[0].relativeVelocity.kms)")
		    
		    Text("Estimated Diameter: ")
		    +
		    Text("\(asteroid.estimatedDiameter.diamter)")
		    
		    Text("Absolute Magnitude: \(asteroid.absoluteMagnitudeH.removeZerosFromEnd()) M")
		    
		}
		
		Section("Close Aproaches") {
		    
		    ScrollView(.horizontal, showsIndicators: false){
			
			HStack {
			    ForEach(asteroid.closeApproachData, id: \.epochDateCloseApproach){ entry in
				CloseApproachCard(entry: entry)
			    }
			}
			.scrollTargetLayout()
		    }
		    .scrollTargetBehavior(.viewAligned)
		    .contentMargins(20, for: .scrollContent)
		}
		
		Section("Orbital Data") {
	    
		    Text("First Observation: \(asteroid.orbitalData.firstObservationDate.formattedDate)")
		    
		    Text("Last OBservation: \(asteroid.orbitalData.lastObservationDate.formattedDate)")
		    
		}
		
	    }
	    .navigationTitle(asteroid.nameLimited)
	    .navigationBarTitleDisplayMode(.inline)
	    .listStyle(.plain)
	    .toolbar {
		Menu("Unit", systemImage: "ruler") {
		    Picker("Unit", selection: $viewModel.distance) {
			ForEach(Distance.allCases, id: \.self) { unitCase in
			    Text(unitCase.rawValue.capitalized).tag(unitCase)
			}
		    }
		}
		
		Menu("Unit", systemImage: "waveform") {
		    Picker("Unit", selection: $viewModel.speed) {
			    Text("km/s")
			    Text("km/hour")
			    Text("mph")
		    }
		}
	    }
	    .onAppear {
		viewModel.distance = unitSelection
	    }
	    .onChange(of: viewModel.distance) {
		unitSelection = viewModel.distance
	    }
	}
    }
}

#Preview {
    CollectionDetailView(asteroid: CollectionNearEarthObject.example )
}

extension CollectionDetailView {
    
    var missDistance: String {
	switch viewModel.distance {
	case .kilometers:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.kilometers.beforeDecimal + " km"
	case .miles:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.miles.beforeDecimal + " miles"
	case .lunar:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.lunar.beforeDecimal + " lunar distances"
	case .astronomical:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.astronomical + " au"
	}
    }
    
}
