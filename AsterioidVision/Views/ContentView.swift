//
//  ContentView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/16/24.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
	
	NavigationStack {
	    ScrollView{
		
		MySceneView(model: "asteroidbelt.usdz", rotationX: 0, rotationY: 0, rotationZ: 0, allowsCameraControl: true)
		    .frame(height: 200)
		    .scaleEffect(4)
		    .rotationEffect(.degrees(-10), anchor: .top)
		
		VStack(alignment: .leading){
		    Text("HAZARDOUS")
			.font(.headline)
			.foregroundStyle(.red)
		    
		    ScrollView(.horizontal, showsIndicators: false){
			if viewModel.hazardousAsteroids.isEmpty{
			    
			    ContentUnavailableView("No hazards to show", systemImage: "eye.slash.fill")
				.foregroundStyle(.white)
			}
			else{
			    LazyHStack{
				ForEach(viewModel.hazardousAsteroids) { asteroid in
				    NavigationLink {
					AsteroidDetailView(asteroid: asteroid)
				    } label: {
					AsteroidCard(asteroid: asteroid)
				    }
				}
			    }
			    .scrollTargetLayout()
			}
		    }
		    .scrollTargetBehavior(.viewAligned)
		}
		.safeAreaPadding(.horizontal, 10.0)
		
		VStack(alignment: .leading){
		    Text("Near Earth Objects")
			.font(.headline)
			.foregroundStyle(.white)
		    
		    ScrollView(.horizontal, showsIndicators: false){
			
			if viewModel.nonHazardousAsteroids.isEmpty {
			    ContentUnavailableView("No objects to show", systemImage: "eye.slash.fill")
				.foregroundStyle(.white)
			}
			else {
			    LazyHStack{
				ForEach(viewModel.nonHazardousAsteroids) { asteroid in
				    NavigationLink {
					AsteroidDetailView(asteroid: asteroid)
				    } label: {
					AsteroidCard(asteroid: asteroid)
				    }
				}
			    }
			    .scrollTargetLayout()
			}
		    }
		    .scrollTargetBehavior(.viewAligned)
		}
		.safeAreaPadding(.horizontal, 10.0)
		
	    }
	    .toolbar {
		
		
		Image(systemName: "calendar")
		    .foregroundStyle(.blue)
		    .overlay {
			DatePicker("Date",selection: $viewModel.date, in: ...Date())
			    .labelsHidden()
			    .contentShape(Rectangle())
			    .opacity(0.011)
		    }
		
		
		
	    }
	    .background(Image("background"))
	    .navigationTitle("Asteroids \(viewModel.date.shortDate)")
	    .navigationBarTitleTextColor(.white)
	}
    }
}

#Preview {
    ContentView()
}
