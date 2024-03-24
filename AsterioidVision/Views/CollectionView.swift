//
//  CollectionView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CollectionView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
	
	NavigationStack {
	    
	    List {
		
		VStack{
		    MySceneView(model: "earth.usdz", rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
			.frame(height: 150)
			.scaleEffect(1.5)
			.padding()
		}
		.listRowSeparator(.hidden)
		
		Section("Asteroid Collection"){
		    ForEach(viewModel.collection) { asteroid in
			NavigationLink{
			    
			} label: {
			    Text(asteroid.nameLimited)
			}
		    }
		}
	    }
	    .navigationTitle("Collection")
	    .listStyle(.plain)
	}
    }
}

#Preview {
    CollectionView()
}
