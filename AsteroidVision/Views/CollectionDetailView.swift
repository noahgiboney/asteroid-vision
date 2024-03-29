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
    
    var earthApproaches: [CloseApproachData] {
	return asteroid.closeApproachData.filter { entry in
	    let formatter = DateFormatter()
	    formatter.dateFormat = "yyyy-MM-dd"
	    if let date = formatter.date(from: entry.closeApproachDate){
		return date > Date()
	    }
	    return false
	}
    }
    
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
		    Text("Relative Velocity: \(objectVelocity)")
		    
		    Text("Estimated Diameter:  \(objectDiameter)")
		    
		    Text("Absolute Magnitude: \(asteroid.absoluteMagnitudeH.removeZerosFromEnd()) M")
		}
		
		Section("Future Approaches") {
		    ScrollView(.horizontal, showsIndicators: false){
			
			HStack {
			    ForEach(earthApproaches, id: \.epochDateCloseApproach){ entry in
				CloseApproachCard(entry: entry)
				    .padding(.leading, 15)
			    }
			}
			.scrollTargetLayout()
		    }
		    
		    .scrollTargetBehavior(.viewAligned)
		    .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
		}
		.listRowSeparator(.hidden)
		
		Section("Orbital Data") {
		    
		    Text("First Observation: \(asteroid.orbitalData.firstObservationDate.formattedDate)")
		    
		    Text("Last Observation: \(asteroid.orbitalData.lastObservationDate.formattedDate)")
		}
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
    
    var objectVelocity: String {
	switch speedSelection {
	case .kmPerS:
	    asteroid.closeApproachData[0].relativeVelocity.kilometersPerSecond.beforeDecimal + " km/s"
	case .kmPerH:
	    asteroid.closeApproachData[0].relativeVelocity.kilometersPerHour.beforeDecimal + " km/hr"
	case .mph:
	    asteroid.closeApproachData[0].relativeVelocity.milesPerHour.beforeDecimal + " mph"
	}
    }
    
    var objectDiameter: String {
	switch diameterSelection {
	case .kilometers:
	    "\(asteroid.estimatedDiameter.kilometers.diameter)" + " km"
	case .meters:
	    "\(asteroid.estimatedDiameter.meters.diameter)" + " m"
	case .miles:
	    "\(asteroid.estimatedDiameter.miles.diameter)" + " miles"
	case .feet:
	    "\(asteroid.estimatedDiameter.feet.diameter)" + " ft"
	}
    }
}
