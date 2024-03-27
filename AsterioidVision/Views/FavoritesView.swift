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
		
		
		ForEach(displayList) { item in
		    HStack{
		        Text(item.name)
			Spacer()
			VStack {
			    Text("Coming")
			    Text("\(item.closestApproach?.formattedDate ?? "NA")")
			}
		    }
		}
		.onDelete(perform: { indexSet in
		    favorites.deleteAt(offset: indexSet)
		})
	    }
	    .navigationTitle("Favorites")
	    .navigationBarTitleDisplayMode(.inline)
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
