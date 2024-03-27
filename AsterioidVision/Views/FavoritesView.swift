//
//  FavoritesView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(Favorites.self) var favorites
    
    var body: some View {
	NavigationStack {
	    List{
		ForEach(favorites.list) { item in
		    Text(item.name)
		}
		.onDelete(perform: { indexSet in
		    favorites.deleteAt(offset: indexSet)
		})
	    }
	    .navigationTitle("Favorites")
	    .navigationBarTitleDisplayMode(.inline)
	    .toolbar {
		EditButton()
	    }
	}
    }
}

#Preview {
    
    FavoritesView()
	.environment(Favorites())
}
