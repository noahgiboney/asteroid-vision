//
//  AsteroidCard.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/21/24.
//

import SwiftUI

struct AsteroidCard: View {
    
    var asteroid: NearEarthObject
    
    var body: some View {
	VStack {
	    Text(asteroid.name).font(.headline)
	    
	    MySceneView(model: "asteroidmodel.usdz", rotationX: Float(Int.random(in: 0...3)), rotationY: Float(Int.random(in: 0...3)), rotationZ: Float(Int.random(in: 0...3)), allowsCameraControl: false)
	    
	}
	.frame(width: 140, height: 140)
	.padding()
	.background(Color.gray.opacity(0.1))
	.clipShape(RoundedRectangle(cornerRadius: 25))
	.foregroundStyle(.white)
    }
}

#Preview {
    AsteroidCard(asteroid: NearEarthObject.example)
	.preferredColorScheme(.dark)
}
