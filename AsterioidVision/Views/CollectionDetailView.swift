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
    
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    var asteroid: NearEarthObject
    
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
		
		Section{
		    
		    Text(missDistance)
		    
		    Text(velocity)
		    
		    Text(objectDiameter)
		    
		    Text("Absolute Magnitude: \(asteroid.absoluteMagnitudeH.removeZerosFromEnd()) M")
		    
		}
		
		Section("Orbital Data") {
		    
		    Text("First Observation: \(asteroid.orbitalData.firstObservationDate.formattedDate)")
		    
		    Text("Last Observation: \(asteroid.orbitalData.lastObservationDate.formattedDate)")
		}
		
		Section("Close Aproaches") {
		    
		    ScrollView(.horizontal, showsIndicators: false){
			
			HStack {
			    ForEach(asteroid.closeApproachData, id: \.epochDateCloseApproach){ entry in
				CloseApproachCard(entry: entry)
				    .padding(.leading, 10)
			    }
			}
			.scrollTargetLayout()
		    }

		    .scrollTargetBehavior(.viewAligned)
		    .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
		    
		}
		.listRowSeparator(.hidden)
	    }
	    .listStyle(.plain)
	    .navigationTitle(asteroid.name)
	    .navigationBarTitleDisplayMode(.inline)
	    .alert("Remove \(asteroid.name)", isPresented: $showingAlert) {
		Button("Remove", role: .destructive) {
		    favorites.delete(asteroid)
		}
	    } message: {
		Text("Are you sure you want to remove \(asteroid.name) from your favorites?")
	    }
	    .toolbar {
		ToolbarItem(placement: .topBarTrailing) {
		    Button {
			showingSheet.toggle()
		    } label: {
			Image(systemName: "ruler")
		    }
		}
		
		ToolbarItem(placement: .topBarTrailing){
		    Button{
			handleButtonPress()
		    } label: {
			Image(systemName: favorites.contains(asteroid) ? "star.fill" : "star")
		    }
		}
	    }
	    .sheet(isPresented: $showingSheet) {
		UnitView()
		    .presentationDetents([.fraction(0.35)])
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
    CollectionDetailView(asteroid: NearEarthObject.example)
	.environment(Favorites())
}

extension CollectionDetailView {
    
    var missDistance: String {
	switch distanceSelection {
	case .kilometers:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.kilometers + " km"
	case .miles:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.miles + " miles"
	case .lunar:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.lunar + " lunar distances"
	case .astronomical:
	    "Miss Distance: " + asteroid.closeApproachData[0].missDistance.astronomical + " au"
	}
    }
    
    var velocity: String {
	switch speedSelection {
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
    
    var objectDiameter: String {
	switch diameterSelection {
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
