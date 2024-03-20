//
//  ContentView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/16/24.
//

import SwiftUI

struct ContentView: View {
    
    let formatter = DateFormatter()
    
    var currentDate: String {
	let formatter = DateFormatter()
	formatter.dateFormat = "yyyy'-'mm'-'dd"
	return formatter.string(from: Date())
    }
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
	
	NavigationStack {
	    List(viewModel.asteroids) { asteroid in
		Text(asteroid.name)
	    }
	}
    }
    
    func fetchAsteriods() async throws {
	
	
	
    }
}

#Preview {
    ContentView()
}
