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
	    
	    HazerdousView()
		.tabItem { Label("Hazerdous", systemImage: "hazardsign") }
	    
	    CollectionView()
		.tabItem { Label("Collection", systemImage: "globe.central.south.asia.fill") }
	    
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
