//
//  AsteroidDetailScreen.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import SwiftUI

struct AsteroidDetailScreen: View {
    var asteroidId: String
    @EnvironmentObject var viewModel: ViewModel
    @Environment(Favorites.self) var favorites
    @Environment(UnitSettings.self) var units
    @Environment(\.dismiss) var dismiss
    @State private var showingUnitSettings = false
    @State private var asteroid: NearEarthObject?
    @State private var closeApproaches: [CloseApproachData] = []
    
    init(asteroidId: String, asteroid: NearEarthObject? = nil) {
        self.asteroidId = asteroidId
        
        if let asteroid = asteroid {
            self._asteroid = State(initialValue: asteroid)
        }
    }
    
    var body: some View {
        Group {
            if let asteroid = asteroid {
                List {
                    SceneView(model: .asteroid, rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
                        .frame(height: 100)
                        .listRowBackground(Color.clear)
                    
                    Section("Details"){
                        Text("Relative Velocity: ")
                            .fontWeight(.semibold) +
                        Text("\(asteroid.velocity(unit: units.velocity))")
                             
                        Text("Estimated Diameter: ")
                            .fontWeight(.semibold) +
                        Text("\(asteroid.diameter(unit: units.diameter))")
                    
                        Text("Absolute Magnitude: ")
                            .fontWeight(.semibold) +
                        Text("\(asteroid.absoluteMagnitudeH.removeZerosFromEnd())")
                    }
                    
                    Section("History of Approaches") {
                        if closeApproaches.isEmpty {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .listRowBackground(Color.clear)
                        } else {
                            ForEach(closeApproaches, id: \.epochDateCloseApproach) { entry in
                                CloseApproachView(entry: entry)
                            }
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(asteroid?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingUnitSettings) {
            UnitSettingsScreen(units: units)
                .presentationDetents([.fraction(0.40)])
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Button("Favorite", systemImage: favorites.contains(asteroidId) ? "star.fill" : "star") {
                    onSave(asteroidId)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingUnitSettings.toggle()
                } label: {
                    Image(systemName: "ruler")
                }
            }
        }
        .alert(isPresented: $viewModel.showingError, error: viewModel.error) { error in
            Button("OK") {
                viewModel.error = nil
                dismiss()
            }
        } message: { error in
            Text(error.failureReason)
        }
        .task {
            await fetchCloseApproaches()
            if asteroid == nil {
                asteroid = await viewModel.fetchAsteroid(id: asteroidId)
            }
        }
    }
    
    func onSave(_ asteroidId: String) {
        if favorites.contains(asteroidId) {
            favorites.delete(asteroidId)
        } else {
            favorites.add(asteroidId)
        }
    }
    
    func fetchCloseApproaches() async {
        let asteroid = await viewModel.fetchAsteroid(id: asteroidId)
        if let asteroid = asteroid {
            closeApproaches = asteroid.closeApproachData
        }
    }
}

#Preview {
    AsteroidDetailScreen(asteroidId: NearEarthObject.example.id)
        .environmentObject(ViewModel(service: APIService()))
        .environment(Favorites())
        .environment(UnitSettings())
}
