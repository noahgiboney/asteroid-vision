//
//  Home.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/22/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
	TabView {
	    DailyView()
		.tabItem { Label("Daily", systemImage: "calendar") }
	    
	    Text("g")
		.tabItem { Label("Hazerdous", systemImage: "hazardsign") }
	    
	    Text("g")
		.tabItem { Label("All Asteroids", systemImage: "plus") }
	}
    }
}

#Preview {
    Home()
}
