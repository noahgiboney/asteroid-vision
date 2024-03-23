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
		DatePicker("Near earth objects for:", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
		VStack{
		
		    
		    MySceneView(model: "earth.usdz", rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
			.frame(height: 200)
			.padding()
			
			.scaleEffect(1.5)
		    
		}

		.listRowSeparator(.hidden)
		
		
		
		Section("Near Earth Objects"){
		    ForEach(viewModel.asteroids) { example in
			VStack {
			    NavigationLink {
				
			    } label :{
				VStack(alignment: .leading){
				    Text(example.name)
					.font(.headline)
				    Text(example.isPotentiallyHazardousAsteroid ? "Hazard": "Non-Hazard")
					.foregroundStyle(example.isPotentiallyHazardousAsteroid ? .red : .black)
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
