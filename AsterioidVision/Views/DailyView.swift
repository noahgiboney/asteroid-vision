//
//  DaileyView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/22/24.
//

import SwiftUI

struct DailyView: View {
    
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
		
		DatePicker("Near earth objects for:", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
		    .listRowSeparator(.hidden)
		
		Section("Near Earth Objects"){
		    
		    ForEach(viewModel.asteroids) { asteroid in
			VStack {
			    
			    NavigationLink {
				DetailView(asteroid: asteroid)
			    } label :{
				VStack(alignment: .leading){
				    Text(asteroid.name)
					.font(.headline)
				    
				    Text(asteroid.isPotentiallyHazardousAsteroid ? "Hazard": "Non-Hazard")
					.foregroundStyle(asteroid.isPotentiallyHazardousAsteroid ? .red : .black)
					.font(.caption)
				}
			    }
			    
			}
			
		    }
		}
	    }
	    .navigationTitle("\(viewModel.date.shortDate) Asteroids")
	    .listStyle(.plain)
	}
    }
}

#Preview {
    DailyView()
}
