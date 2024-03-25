//
//  FavoritesView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
	NavigationStack {
	    List{
		
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
}
