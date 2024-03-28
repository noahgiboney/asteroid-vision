//
//  UnitView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/27/24.
//

import SwiftUI

struct UnitView: View {
    
    @AppStorage("distance") var distanceSelection: Distance = .miles
    @AppStorage("speed") var speedSelection: Speed = .kmPerS
    @AppStorage("diameter") var diameterSelection: Diameter = .kilometers
    @Environment(\.dismiss) var dismiss
    
    @State private var distance: Distance = .kilometers
    @State private var speed: Speed = .kmPerS
    @State private var diameter: Diameter = .kilometers
    
    var body: some View {
	NavigationStack{
	    Form {
		
		Picker(selection: $diameter) {
		    ForEach(Diameter.allCases, id: \.self) { unitCase in
			Text(unitCase.rawValue.capitalized).tag(unitCase)
		    }
		} label: {
		    Label("Estimated Diameter", systemImage: "ruler")
		}
		
		Picker(selection: $distance) {
		    ForEach(Distance.allCases, id: \.self) { unitCase in
			Text(unitCase.rawValue.capitalized).tag(unitCase)
		    }
		} label: {
		    Label("Miss Distance", systemImage: "ruler")
		}
		
		Picker(selection: $distance) {
		    Text("km/s").tag(Speed.kmPerS)
		    Text("km/hour").tag(Speed.kmPerH)
		    Text("mph").tag(Speed.mph)
		} label: {
		    Label("Relative Velocity", systemImage: "gauge.open.with.lines.needle.33percent")
		}
	    }
	    .navigationTitle("Unit Selection")
	    .navigationBarTitleDisplayMode(.inline)
	    .onAppear {
		distance = distanceSelection
		speed = speedSelection
		diameter = diameterSelection
	    }
	    .onChange(of: distance) {
		distanceSelection = distance
	    }
	    .onChange(of: speed) {
		speedSelection = speed
	    }
	    .onChange(of: diameter) {
		diameterSelection = diameter
	    }
	    .toolbar {
		ToolbarItem(placement: .topBarLeading) {
		    Button{
			dismiss()
		    } label: {
			Image(systemName: "x.circle.fill")
		    }
		}
	    }
	}
    }
}

#Preview {
    UnitView()
}
