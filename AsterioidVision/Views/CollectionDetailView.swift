//
//  CollectionDetailView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CollectionDetailView: View {
    
    @AppStorage("Unit") var unitSelection: Unit = .miles
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
		    
		    Text("Miss Distance: ")
		    +
		    Text("\(asteroid.closeApproachData[0].missDistance.kilometers.beforeDecimal) km")
		    
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
		}
		
		Section("Orbit Data") {
		    
		    
		}
		
	    }
	    .navigationTitle(asteroid.nameLimited)
	    .navigationBarTitleDisplayMode(.inline)
	    .listStyle(.plain)
	    .toolbar {
		Menu("Unit", systemImage: "ruler") {
		    Picker("Unit", selection: $viewModel.unit) {
			ForEach(Unit.allCases, id: \.self) { unitCase in
			    Text(unitCase.rawValue.capitalized).tag(unitCase)
			}
		    }
		}
	    }
	    .onAppear {
		viewModel.unit = unitSelection
	    }
	    .onChange(of: viewModel.unit) {
		unitSelection = viewModel.unit
	    }
	}
    }
}

#Preview {
    CollectionDetailView(asteroid: CollectionNearEarthObject.example )
}
