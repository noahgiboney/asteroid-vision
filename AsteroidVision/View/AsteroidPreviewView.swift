//
//  AsteroidPreivewView.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import SwiftUI

struct AsteroidPreviewView: View {
    @Environment(\.colorScheme) var scheme
    @Environment(UnitSettings.self) var units
    var asteroid: NearEarthObject
    
    var body: some View {
        VStack {
            SceneView(model: .asteroid,
                      rotationX: Float.random(in: 0.2..<1),
                      rotationY: Float.random(in: 0.2..<1),
                      rotationZ: Float.random(in: 0.2..<1),
                      allowsCameraControl: false)
            .frame(height: 100)
            .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(asteroid.name)
                    .font(.headline)
                
                Text("Next Approach on \(asteroid.nextCloseApproach)")
                    .font(.footnote)
                
                Text("Traveling \(asteroid.velocity(unit: units.velocity))")
                    .font(.footnote)
            }
        }
        .foregroundStyle(scheme == .dark ? .white : .black)
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    AsteroidPreviewView(asteroid: .example)
        .environment(UnitSettings())
}