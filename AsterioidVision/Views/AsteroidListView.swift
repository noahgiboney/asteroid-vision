//
//  HazerdousView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct AsteroidListView: View {
    
    @Environment(Favorites.self) var favorites
    @State private var viewModel = ViewModel()
    @State private var date = Date()
    
    
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
		    
		    if displayedItems.isEmpty && !viewModel.searchTerm.isEmpty {
			ContentUnavailableView("No matches", systemImage: "eye.slash")
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
					Text(asteroidType == .hazard ? "Coming" : "Observed")
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
		viewModel.handleRefresh()
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
	    "Hazerdous"
	case .nonHazard:
	    "Non Hazerdous"
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
    
    var displayedItems: [CollectionNearEarthObject] {
	let list: [CollectionNearEarthObject]
	
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
	
	if viewModel.searchTerm == "" {
	    return list
	}
	else {
	    return list.filter { asteroid in
		asteroid.name.localizedStandardContains(viewModel.searchTerm)
	    }
	}
    }
    
    func approachDate(for asteroid: CollectionNearEarthObject) -> String {
	
	if asteroidType == .hazard {
	    return asteroid.closestApproach ?? "NA"
	}
	else {
	    return asteroid.orbitalData.lastObservationDate.formattedDate
	}
    }
}
