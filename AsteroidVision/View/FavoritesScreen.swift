//
//  FavoritesScreen.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import SwiftUI

struct FavoritesScreen: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(Favorites.self) var favorites
    @State private var favoriteAsteroids: [NearEarthObject] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    if favoriteAsteroids.isEmpty {
                        ContentUnavailableView("No favorites yet", image: "asteroid")
                    } else {
                        List {
                            ForEach(favoriteAsteroids) { asteroid in
                                NavigationLink {
                                    AsteroidDetailScreen(asteroidId: asteroid.id, asteroid: asteroid)
                                } label: {
                                    Text(asteroid.name)
                                }
                            }
                            .onDelete { indexSet in
                                delete(at: indexSet)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .toolbar {
                EditButton()
            }
            .task {
                favoriteAsteroids = await viewModel.fetchFavorites(favorites: Array(favorites.favorites))
                isLoading = false
            }
        }
    }
    
    func delete(at offset: IndexSet) {
        favorites.onDelete(at: offset)
        favoriteAsteroids.remove(atOffsets: offset)
    }
}

#Preview {
    FavoritesScreen()
        .environmentObject(ViewModel(service: APIService()))
        .environment(Favorites())
}
