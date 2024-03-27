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
    
    @State private var showingAlert = false
    
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
			    HStack{
				if favorites.contains(asteroid) {
				    Image(systemName: "star.fill")
				}
				Text(asteroid.name)
				Spacer()
				VStack {
				    Text("Coming")
				    Text("\(asteroid.closestApproach?.formattedDate ?? "NA")")
				}
			    }
			    .onAppear {
				if asteroid == viewModel.hazards.last{
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
		}
		
	    }
	    .refreshable {
		viewModel.handleRefresh()
	    }
	    .alert("alert", isPresented: $showingAlert) {
		
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
