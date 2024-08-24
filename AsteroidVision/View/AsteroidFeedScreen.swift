//
//  AsteroidFeedScreen.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/22/24.
//

import SwiftUI

struct AsteroidFeedScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ViewModel(service: APIService())
    @State private var units = UnitSettings()
    @State private var favorites = Favorites()
    @State private var showingUnitSettings = false
    @State private var isLoading = true
    @State private var dub = 0.0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    DatePicker("Asteroids for", selection: $viewModel.date, displayedComponents: .date)
                    
                    DisclosureGroup("Filter") {
                        VStack {
                            Text("Minimum Velocity")
                            Slider(value: $dub)
                        }
                    }
                }
                
                SceneView(model: .earth, rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
                    .listRowBackground(Color.clear)
                    .frame(height: 150)
                    .scaleEffect(1.5)
                    .shadow(radius: 5)
                    .listRowSeparator(.hidden)
                    .padding()
                
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(viewModel.feed) { asteroid in
                        AsteroidPreviewView(asteroid: asteroid)
                            .background {
                                NavigationLink("", destination: AsteroidDetailScreen(asteroidId: asteroid.id, asteroid: asteroid))
                                .opacity(0.0)
                            }
                            .listRowSeparator(.hidden)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Asteroid Vision")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingUnitSettings) {
                UnitSettingsScreen(units: units)
                    .presentationDetents([.fraction(0.40)])
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        showingUnitSettings.toggle()
                    } label: {
                        Image(systemName: "ruler")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink {
                        FavoritesScreen()
                    } label: {
                        Image(systemName: "star")
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
                await viewModel.populateFeed()
                isLoading = false
            }
        }
        .environmentObject(viewModel)
        .environment(units)
        .environment(favorites)
    }
}

#Preview {
    AsteroidFeedScreen()
        .environmentObject(ViewModel(service: APIService()))
        .environment(UnitSettings())
        .environment(Favorites())
}
