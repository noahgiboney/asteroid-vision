//
//  HazerdousView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct HazerdousView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
	
	NavigationStack {
	    
	    List {
		
		ForEach(viewModel.hazards) { asteroid in
		    Text(asteroid.nameLimited)
		}
		
	    }
	    .navigationTitle("Hazerdous")
	    .listStyle(.plain)
	}
    }
}

#Preview {
    HazerdousView()
}
