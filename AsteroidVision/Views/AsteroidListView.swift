//
//  HazerdousView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct AsteroidListView: View {
    
    @AppStorage("distance") var distanceSelection: Distance = .miles
    @AppStorage("speed") var speedSelection: Speed = .kmPerS
    @AppStorage("diameter") var diameterSelection: Diameter = .kilometers
    @Environment(Favorites.self) var favorites
    
    @State private var viewModel = ViewModel()
    @State private var showingErrorAlert = false
    
    var asteroidType: AsteroidType
    
    var body: some View {
	
	NavigationStack {
	    
	    List {
		
		VStack{
		    MySceneView(model: planet, rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
			.frame(height: 150)
			.scaleEffect(1.5)
			.padding()
		}
		.listRowSeparator(.hidden)
		
		Section("\(title) Asteroids"){
		    
		    if displayedItems.isEmpty && !viewModel.isLoading{
			ContentUnavailableView("No matches", image: "asteroid")
			    .listRowSeparator(.hidden)
		    } else {
			ForEach(displayedItems) { asteroid in
			    NavigationLink{
				CollectionDetailView(asteroid: asteroid)
			    } label: {
				HStack{
				    if favorites.contains(asteroid) {
					Image(systemName: "star.fill")
				    }
				    Text(asteroid.name)
				    Spacer()
				    VStack(alignment: .trailing) {
					Text(asteroidType == .hazard ? "Next Approach" : "Last Observed")
					Text(approachDate(for: asteroid))
				    }
				}
				.onAppear {
				    if asteroid == displayedItems.last{
					viewModel.loadHazards()
				    }
				}
			    }
			    .swipeActions {
				if favorites.contains(asteroid) == false {
				    Button{
					favorites.add(asteroid)
				    } label: {
					Image(systemName: "star")
				    }
				    .tint(.blue)
				}
				else {
				    Button{
					favorites.delete(asteroid)
				    } label: {
					Image(systemName: "star.slash")
				    }
				    .tint(.red)
				}
			    }
			}
			if viewModel.isLoading {
			    HStack{
				Spacer()
			        ProgressView()
				Spacer()
			    }
			    .listRowSeparator(.hidden)
			}
		    }
		}
	    }
	    .navigationTitle(title)
	    .listStyle(.plain)
	    .searchable(text: $viewModel.searchTerm, prompt: "Search by name")
	    .refreshable {
		if NetworkService.shared.errorMessage != nil{
		    showingErrorAlert.toggle()
		}
		viewModel.handleRefresh()
	    }
	    .toolbar {
		Button {
		    viewModel.showingFilterSheet.toggle()
		} label: {
		    Image(systemName: "line.3.horizontal.decrease.circle")
		}
	    }
	    .sheet(isPresented: $viewModel.showingFilterSheet) {
		FilterView(minVelocity: $viewModel.minVelocity, minDiameter: $viewModel.minDiameter, minMagnitude: $viewModel.minMagnitude)
		    .presentationDetents([.medium])
	    }
	    .onChange(of: NetworkService.shared.errorMessage) {
		if NetworkService.shared.errorMessage != nil {
		    showingErrorAlert.toggle()
		}
	    }
	    .alert("Error", isPresented: $showingErrorAlert) {
	    } message: {
		if let message = NetworkService.shared.errorMessage {
		    Text(message)
		}
	    }
	}
    }
}

#Preview {
    AsteroidListView(asteroidType: .nonHazard)
	.environment(Favorites())
}

extension AsteroidListView {
    
    var title: String {
	switch asteroidType {
	case .hazard:
	    "Hazardous"
	case .nonHazard:
	    "Non-Hazardous"
	}
    }
    
    var planet: String {
	switch asteroidType {
	case .hazard:
	    "venus.usdz"
	case .nonHazard:
	    "earth.usdz"
	}
    }
    
    var displayedItems: [NearEarthObject] {
	var list: [NearEarthObject]
	
	switch asteroidType {
	case .hazard:
	    list = viewModel.asteroidCollection.filter({ asteroid in
		asteroid.isPotentiallyHazardousAsteroid
	    })
	case .nonHazard:
	    list = viewModel.asteroidCollection.filter({ asteroid in
		!asteroid.isPotentiallyHazardousAsteroid
	    })
	}
	
	list = filterDiameter(list)
	list = filterVelocity(list)
	list = filterMagnitude(list)
	
	if viewModel.searchTerm == "" {
	    return list
	}
	else {
	    return list.filter { asteroid in
		asteroid.name.localizedStandardContains(viewModel.searchTerm)
	    }
	}
    }
    
    func approachDate(for asteroid: NearEarthObject) -> String {
	
	if asteroidType == .hazard {
	    return asteroid.closestApproach ?? "NA"
	}
	else {
	    return asteroid.orbitalData.lastObservationDate.formattedDate
	}
    }
    
    private func filterVelocity(_ list: [NearEarthObject]) -> [NearEarthObject] {
	switch speedSelection {
	case .mph:
	    return list.filter { asteroid in
		let double = Double(asteroid.closeApproachData[0].relativeVelocity.milesPerHour) ?? 0
		return double >= viewModel.minVelocity
	    }
	case .kmPerS:
	    return list.filter { asteroid in
		let double = Double(asteroid.closeApproachData[0].relativeVelocity.kilometersPerSecond) ?? 0
		return double >= viewModel.minVelocity
	    }
	case .kmPerH:
	    return list.filter { asteroid in
		let double = Double(asteroid.closeApproachData[0].relativeVelocity.kilometersPerHour) ?? 0
		return double >= viewModel.minVelocity
	    }
	}
    }
    
    private func filterDiameter(_ list: [NearEarthObject]) -> [NearEarthObject] {
	switch diameterSelection {
	case .feet:
	    return list.filter { asteroid in
		asteroid.estimatedDiameter.feet.averageDiameter >= viewModel.minDiameter
	    }
	case .meters:
	    return list.filter { asteroid in
		asteroid.estimatedDiameter.meters.averageDiameter >= viewModel.minDiameter
	    }
	case .kilometers:
	    return list.filter { asteroid in
		asteroid.estimatedDiameter.kilometers.averageDiameter >= viewModel.minDiameter
	    }
	case .miles:
	    return list.filter { asteroid in
		asteroid.estimatedDiameter.miles.averageDiameter >= viewModel.minDiameter
	    }
	}
    }
    
    private func filterMagnitude(_ list: [NearEarthObject]) -> [NearEarthObject] {
	return list.filter { asteroid in
	    asteroid.absoluteMagnitudeH >= viewModel.minMagnitude
	}
    }
}