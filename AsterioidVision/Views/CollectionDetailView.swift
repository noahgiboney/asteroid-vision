//
//  CollectionDetailView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CollectionDetailView: View {
    
    @AppStorage("distance") var distanceSelection: Distance = .miles
    @AppStorage("speed") var speedSelection: Speed = .kmPerS
    @AppStorage("diameter") var diameterSelection: Diameter = .kilometers
    @Environment(Favorites.self) private var favorites
    
    @State private var viewModel = ViewModel()
    @State private var showingAlert = false
    
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
		    
		    HStack{
		        Text(missDistance)
			Spacer()
			Menu("", systemImage: "list.bullet") {
			    Picker("", selection: $viewModel.distance) {
				ForEach(Distance.allCases, id: \.self) { unitCase in
				    Text(unitCase.rawValue.capitalized).tag(unitCase)
				}
			    }
			}
		    }
		    
		    HStack{
		        Text(velocity)
			Spacer()
			Menu("", systemImage: "list.bullet") {
			    Picker("", selection: $viewModel.speed) {
				Text("km/s").tag(Speed.kmPerS)
				Text("km/hour").tag(Speed.kmPerH)
				Text("mph").tag(Speed.mph)
			    }
			}
		    }
		    
		    HStack{
			Text(diameter)
			Spacer()
			Menu("", systemImage: "list.bullet") {
			    Picker("", selection: $viewModel.diameter) {
				ForEach(Diameter.allCases, id: \.self) { unitCase in
				    Text(unitCase.rawValue.capitalized).tag(unitCase)
				}
			    }
			}
		    }
		    
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
		.listRowSeparator(.hidden)
		
		Section("Orbital Data") {
	    
		    Text("First Observation: \(asteroid.orbitalData.firstObservationDate.formattedDate)")
		    
		    Text("Last OBservation: \(asteroid.orbitalData.lastObservationDate.formattedDate)")
		    
		}
		
	    }
	    .navigationTitle(asteroid.name)
	    .navigationBarTitleDisplayMode(.inline)
	    .listStyle(.plain)
	    .onAppear {
		viewModel.distance = distanceSelection
		viewModel.speed = speedSelection
		viewModel.diameter = diameterSelection
	    }
	    .onChange(of: viewModel.distance) {
		distanceSelection = viewModel.distance
	    }
	    .onChange(of: viewModel.speed) {
		speedSelection = viewModel.speed
	    }
	    .onChange(of: viewModel.diameter) {
		diameterSelection = viewModel.diameter
	    }
	    .alert("Remove \(asteroid.name)", isPresented: $showingAlert) {
		Button("Remove", role: .destructive) {
		    favorites.delete(asteroid)
		}
	    } message: {
		Text("Are you sure you want to remove \(asteroid.name) from your favorites?")
	    }
	    .toolbar {
		Button{
		    handleButtonPress()
		} label: {
		    Image(systemName: favorites.contains(asteroid) ? "star.fill" : "star")
		}
	    }
	}
    }
    
    func handleButtonPress() {
	if favorites.contains(asteroid) == false{
	    withAnimation{
		favorites.add(asteroid)
	    }
	}
	else {
	    withAnimation{
		showingAlert.toggle()
	    }
	}
    }
}

#Preview {
    CollectionDetailView(asteroid: CollectionNearEarthObject.example)
	.environment(Favorites())
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
    
    var velocity: String {
	switch viewModel.speed {
	case .kmPerS:
	    "Relative Velocity: " +
	    asteroid.closeApproachData[0].relativeVelocity.kilometersPerSecond.beforeDecimal + " km/s"
	case .kmPerH:
	    "Relative Velocity: " +
	    asteroid.closeApproachData[0].relativeVelocity.kilometersPerHour.beforeDecimal + " km/hr"
	case .mph:
	    "Relative Velocity: " +
	    asteroid.closeApproachData[0].relativeVelocity.milesPerHour.beforeDecimal + " mph"
	}
    }
    
    var diameter: String {
	switch viewModel.diameter {
	case .kilometers:
	    "Estimated Diameter: " +
	    "\(asteroid.estimatedDiameter.kilometers.diameter)" + " km"
	case .meters:
	    "Estimated Diameter: " +
	    "\(asteroid.estimatedDiameter.meters.diameter)" + " m"
	case .miles:
	    "Estimated Diameter: " +
	    "\(asteroid.estimatedDiameter.miles.diameter)" + " miles"
	case .feet:
	    "Estimated Diameter: " +
	    "\(asteroid.estimatedDiameter.feet.diameter)" + " ft"
	}
    }
}
