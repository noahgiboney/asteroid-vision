//
//  HazerdousView.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import StoreKit
import SwiftUI

struct AsteroidListView: View {
    
    @AppStorage("distance") var distanceSelection: Distance = .miles
    @AppStorage("speed") var speedSelection: Speed = .kmPerS
    @AppStorage("diameter") var diameterSelection: Diameter = .kilometers
    @Environment(Favorites.self) var favorites
    @Environment(\.requestReview) var requestReview
    
    @State private var viewModel = ViewModel()
    @State private var showingErrorAlert = false
    
    var asteroidType: AsteroidType
    
    var body: some View {
	
	NavigationStack {
	    List {
		VStack {
		    MySceneView(model: asteroidType == .hazard ? "pluto.usdz" : "earth.usdz", rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
			.frame(height: 150)
			.scaleEffect(1.5)
			.padding()
		}
		.listRowSeparator(.hidden)
		
		Section("\(asteroidType == .hazard ? "Hazardous" : "Non-Hazardous") Asteroids"){
		    
		    if viewModel.isLoading {
			HStack{
			    Spacer()
			    ProgressView()
			    Spacer()
			}
			.listRowSeparator(.hidden)
		    }
		    
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
					if viewModel.favoritesCount == 2 {
					    requestAppStoreReview()
					}
					else if viewModel.favoritesCount < 3{
					    viewModel.favoritesCount += 1
					}
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
		    }
		}
	    }
	    .navigationTitle(asteroidType == .hazard ? "Hazardous" : "Non-Hazardous" )
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
    
    @MainActor
    func requestAppStoreReview(){
	requestReview()
    }
}

#Preview {
    AsteroidListView(asteroidType: .nonHazard)
	.environment(Favorites())
}

extension AsteroidListView {
    
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
    
	if viewModel.searchTerm != "" {
	    list = list.filter { asteroid in
		asteroid.name.localizedStandardContains(viewModel.searchTerm)
	    }
	}
	
	list = filterDiameter(list)
	list = filterVelocity(list)
	list = filterMagnitude(list)
	
	return list
    }
    
    func approachDate(for asteroid: NearEarthObject) -> String {
	
	if asteroidType == .hazard {
	    return asteroid.closestApproach?.formattedDate ?? "NA"
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
