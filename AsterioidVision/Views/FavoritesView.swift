//
//  FavoritesView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct FavoritesView: View {
    
    enum FavoriteType {
	case all, hazard, nonHazard
    }
    
    @Environment(Favorites.self) var favorites
    @State private var showingType: FavoriteType = .all
    
    var displayList: [CollectionNearEarthObject] {
	switch showingType {
	case .all:
	    favorites.list
	case .hazard:
	    favorites.list.filter { item in
		item.isPotentiallyHazardousAsteroid
	    }
	case .nonHazard:
	    favorites.list.filter { item in
		!item.isPotentiallyHazardousAsteroid
	    }
	}
    }
    
    var body: some View {
	NavigationStack {
	    List{
		Picker("Favorites", selection: $showingType) {
		    Text("All").tag(FavoriteType.all)
		    Text("Hazard").tag(FavoriteType.hazard)
		    Text("Non-Hazard").tag(FavoriteType.nonHazard)
		}
		.pickerStyle(.segmented)
		
		
		if favorites.list.isEmpty {
		    ContentUnavailableView("You have no favorites", image: "asteroid")
		}
		else {
		    ForEach(displayList) { item in
			NavigationLink {
			    CollectionDetailView(asteroid: item)
			} label: {
			    HStack{
				VStack(alignment: .leading){
				    Text(item.name)
				    Text(item.isPotentiallyHazardousAsteroid ? "Hazard" : "Non-Hazard")
					.font(.caption)
					.foregroundStyle(item.isPotentiallyHazardousAsteroid ? .red : .black)
				}
				Spacer()
				VStack(alignment: .trailing) {
				    Text(item.isPotentiallyHazardousAsteroid ? "Coming" : "Seen")
				    Text(item.isPotentiallyHazardousAsteroid ? item.closestApproach ?? "NA" : item.orbitalData.lastObservationDate )
				}
			    }
			}
		    }
		    .onDelete(perform: { indexSet in
			favorites.deleteAt(offset: indexSet)
		    })
		}
	    }
	    .navigationTitle("Favorites")
	    .toolbar {
		EditButton()
	    }
	}
    }
}

#Preview {
    
    FavoritesView()
	.environment(Favorites())
}
