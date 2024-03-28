//
//  Home.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/22/24.
//

import SwiftUI

struct Home: View {
    
    @State private var favorites = Favorites()
    
    var body: some View {
	
	TabView {
	    
	    AsteroidListView(asteroidType: .hazard)
		.tabItem { Label("Hazardous", systemImage: "hazardsign") }
	    
	    AsteroidListView(asteroidType: .nonHazard)
		.tabItem { Label("Non-Hazardous", systemImage: "globe.europe.africa") }
	    
	    FavoritesView()
		.tabItem { Label("Favorites", systemImage: "star") }
	    
	}
	.environment(favorites)
    }
}

#Preview {
    Home()
}
