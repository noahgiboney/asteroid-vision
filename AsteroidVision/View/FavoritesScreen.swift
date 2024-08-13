//
//  FavoritesScreen.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import SwiftUI

enum FavoritesState {
    case loaded, empty, loading
}

struct FavoritesScreen: View {
    @Environment(AsteroidStore.self) var store
    @Environment(Favorites.self) var favorites
    @State private var state: FavoritesState = .loading
    @State private var favoriteAsteroids: [NearEarthObject] = []
    
    var body: some View {
        NavigationStack {
            Group {
                switch state {
                case .loaded:
                    List {
                        ForEach(favoriteAsteroids) { asteroid in
                            NavigationLink {
                                AsteroidDetailScreen(asteroid: asteroid)
                            } label: {
                                Text(asteroid.name)
                            }
                        }
                        .onDelete { indexSet in
                            delete(at: indexSet)
                        }
                    }
                case .empty:
                    ContentUnavailableView("No favorites yet", image: "asteroid")
                case .loading:
                    ProgressView()
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
            }
            .onChange(of: favoriteAsteroids) { _, _ in
                if favoriteAsteroids.isEmpty {
                    state = .empty
                }
            }
            .task { try? await fetchFavorites() }
        }
    }
    
    func fetchFavorites() async throws {
        guard state != .loaded else { return }
        
        try await withThrowingTaskGroup(of: NearEarthObject?.self) { taskGroup in
            for id in Array(favorites.favorites) {
                taskGroup.addTask { try? await store.fetchAsteroid(id) }
            }
            
            for try await asteroid in taskGroup {
                if let asteroid = asteroid {
                    favoriteAsteroids.append(asteroid)
                }
            }
        }
        if favoriteAsteroids.isEmpty {
            state = .empty
        } else {
            state = .loaded
        }
    }
    
    func delete(at offset: IndexSet) {
        favorites.onDelete(at: offset)
        favoriteAsteroids.remove(atOffsets: offset)
    }
}

#Preview {
    FavoritesScreen()
        .environment(AsteroidStore())
        .environment(Favorites())
}
