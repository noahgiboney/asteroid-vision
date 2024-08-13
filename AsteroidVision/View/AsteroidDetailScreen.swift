//
//  AsteroidDetailScreen.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import SwiftUI

struct AsteroidDetailScreen: View {
    var asteroid: NearEarthObject
    @Environment(AsteroidStore.self) var store
    @Environment(Favorites.self) var favorites
    @Environment(UnitSettings.self) var units
    @State private var showingControlCenter = false
    
    var body: some View {
        List {
            SceneView(model: .asteroid, rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
                .frame(height: 100)
                .listRowBackground(Color.clear)
            
            Section("Details"){
                Text("Relative Velocity: \(asteroid.velocity(unit: units.velocity))")
                Text("Estimated Diameter: \(asteroid.diameter(unit: units.diameter))")
                Text("Absolute Magnitude: \(asteroid.absoluteMagnitudeH.removeZerosFromEnd())")
            }
            
            Section("Orbital Data") {
                Text("First Observation: \(asteroid.orbitalData.firstObservationDate.formattedDate)")
                
                Text("Last Observation: \(asteroid.orbitalData.lastObservationDate.formattedDate)")
            }
            
            Section("Future Approaches To Earth") {
                ForEach(asteroid.earthApproaches, id: \.epochDateCloseApproach) { entry in
                    CloseApproachView(entry: entry)
                }
            }
        }
        .navigationTitle(asteroid.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingControlCenter) {
            ControlCenterScreen(units: units)
                .presentationDetents([.fraction(0.40)])
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingControlCenter.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing){
                Button("Favorite", systemImage: favorites.contains(asteroid.id) ? "star.fill" : "star") {
                    if favorites.contains(asteroid.id) {
                        favorites.delete(asteroid.id)
                    } else {
                        favorites.add(asteroid.id)
                    }
                }
            }
        }
    }
}

#Preview {
    AsteroidDetailScreen(asteroid: .example)
        .environment(AsteroidStore())
        .environment(Favorites())
        .environment(UnitSettings())
}
