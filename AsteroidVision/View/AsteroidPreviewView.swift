//
//  AsteroidPreivewView.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import SwiftUI

struct AsteroidPreviewView: View {
    var asteroid: NearEarthObject
    @Environment(\.colorScheme) var scheme
    @Environment(UnitSettings.self) var units
    
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
                    .foregroundStyle(asteroid.isPotentiallyHazardousAsteroid ? .red : .primary)
                
                Text("Traveling \(asteroid.velocity(unit: units.velocity))")
                    .font(.footnote)
                    .italic()
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
