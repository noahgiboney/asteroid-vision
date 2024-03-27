//
//  CollectionView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CollectionView: View {
    
    @Environment(Favorites.self) private var favorites
    @State private var viewModel = ViewModel()
    
    var body: some View {
	
	NavigationStack {
	    
	    List {
		
		VStack{
		    MySceneView(model: "venus.usdz", rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
			.frame(height: 150)
			.scaleEffect(1.5)
			.padding()
		}
		.listRowSeparator(.hidden)
		
		Section("Asteroid Collection"){
		    
		    ForEach(viewModel.collection) { asteroid in
			NavigationLink{
			    CollectionDetailView(asteroid: asteroid)
			} label: {
			    HStack{
				Text(asteroid.name)
				Spacer()
				if favorites.contains(asteroid) {
				    Image(systemName: "star.fill")
				}
			    }
			    .onAppear {
				if asteroid == viewModel.collection.last{
				    viewModel.loadCollection()
				}
			    }
			}
		    }
		}
	    }
	    .refreshable {
		viewModel.handleRefresh()
	    }
	    .navigationTitle("Collection")
	    .listStyle(.plain)
	}
    }
}

#Preview {
    CollectionView()
	.environment(Favorites())
}
