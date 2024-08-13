//
//  HazardListScreen.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import SwiftUI

struct AsteroidListScreen: View {
    @State private var store = AsteroidStore()
    @State private var favorites = Favorites()
    @State private var units = UnitSettings()
    @State private var date: Date = .now
    @State private var showingControlCenter = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                SceneView(model: .earth, rotationX: 1, rotationY: 1, rotationZ: 1, allowsCameraControl: true)
                    .frame(height: 150)
                    .scaleEffect(1.5)
                    .padding(.top, 20)
                    .shadow(radius: 10)
            }
            ScrollView {
                if !store.isLoading && store.hazards.isEmpty {
                    ContentUnavailableView("No Results", image: "asteroid")
                } else {
                    LazyVStack{
                        ForEach(store.hazards) { asteroid in
                            NavigationLink {
                                AsteroidDetailScreen(asteroid: asteroid)
                            } label: {
                                AsteroidPreviewView(asteroid: asteroid)
                                    .scrollTransition { content, phase in
                                        content
                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.2)
                                            .opacity(phase.isIdentity ? 1.0 : 0.5)
                                    }
                            }
                            .onAppear {
                                if asteroid == store.hazards.last {
                                    Task { try? await store.loadHazards() }
                                }
                            }
                        }
                    }
                }
                
                if store.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Asteroid Vision")
            .sheet(isPresented: $showingControlCenter) {
                ControlCenterScreen(units: units)
                    .presentationDetents([.fraction(0.40)])
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                       FavoritesScreen()
                    } label: {
                        Image(systemName: "star")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingControlCenter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .task {
                try? await store.loadHazards()
            }
        }
        .environment(store)
        .environment(favorites)
        .environment(units)
    }
}

#Preview {
    NavigationStack {
        AsteroidListScreen()
    }
}
