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
		.tabItem { Label("Hazerdous", systemImage: "hazardsign") }
	    
	    AsteroidListView(asteroidType: .nonHazard)
		.tabItem { Label("Non-Hazerdous", systemImage: "globe") }
	    
	    DailyView()
		.tabItem { Label("Daily", systemImage: "calendar") }
	    
	    FavoritesView()
		.tabItem { Label("Favorites", systemImage: "star") }
	    
	}
	.environment(favorites)
    }
}

#Preview {
    Home()
}
