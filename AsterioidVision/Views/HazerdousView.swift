//
//  HazerdousView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct HazerdousView: View {
    
    @Environment(Favorites.self) var favorites
    @State private var viewModel = ViewModel()
    
    var body: some View {
	
	NavigationStack {
	    
	    List {
		
		VStack{
		    MySceneView(model: "pluto.usdz", rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
			.frame(height: 150)
			.scaleEffect(1.5)
			.padding()
		}
		.listRowSeparator(.hidden)
		
		Section("Hazerdous Asteroids"){
		    ForEach(viewModel.hazards) { asteroid in
			NavigationLink{
			    CollectionDetailView(asteroid: asteroid)
			} label: {
			    Text(asteroid.nameLimited)
			}
			.swipeActions {
			    if favorites.contains(asteroid.id) == false{
			        Button{
				    favorites.add(asteroid.id)
				} label: {
				    Image(systemName: "star")
				}
				.tint(.blue)
			    }
			}
		    }
		}
		
	    }
	    .navigationTitle("Hazerdous")
	    .listStyle(.plain)
	}
    }
}

#Preview {
    HazerdousView()
	.environment(Favorites())
}
