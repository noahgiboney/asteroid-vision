//
//  FilterView.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/27/24.
//

import SwiftUI

struct FilterView: View {
    
    
    @AppStorage("distance") var distanceSelection: Distance = .miles
    @AppStorage("speed") var speedSelection: Speed = .kmPerS
    @AppStorage("diameter") var diameterSelection: Diameter = .kilometers
    @Environment(\.dismiss) var dismiss
    
    @Binding var minVelocity: Double
    @Binding var minDiameter: Double
    @Binding var minMagnitude: Double
    
    @State private var showingUnitSheet = false
    
    var body: some View {
	NavigationStack {
	    Form {
		Section("Minimum Relative Velocity"){
		    VStack{
			Text("\(minVelocity.rounded().removeZerosFromEnd()) " + velocityUnit)
			Slider(value: $minVelocity, in: 0...velocityMax) {
			} minimumValueLabel: {
			    Text("\(0)")
			} maximumValueLabel: {
			    Text("\(velocityMax.removeZerosFromEnd())")
			}
		    }
		}
		
		Section("Minimum Estimated Diameter"){
		    VStack{
			Text("\(minDiameter.rounded().removeZerosFromEnd()) " + diameterUnit)
			Slider(value: $minDiameter, in: 0...diameterMax) {
			} minimumValueLabel: {
			    Text("\(0)")
			} maximumValueLabel: {
			    Text("\(diameterMax.removeZerosFromEnd())")
			}
		    }
		}
		
		Section("Minimum Absolute MAGNITUDE"){
		    VStack{
			Text("\(minMagnitude.rounded().removeZerosFromEnd()) " + "M")
			Slider(value: $minMagnitude, in: 0...20) {
			} minimumValueLabel: {
			    Text("\(0)")
			} maximumValueLabel: {
			    Text("\(20)")
			}
		    }
		}
	    }
	    .navigationTitle("Filter")
	    .navigationBarTitleDisplayMode(.inline)
	    .toolbar {
		
		ToolbarItem(placement: .topBarLeading) {
		    Button{
			dismiss()
		    } label: {
			Image(systemName: "xmark.circle.fill")
		    }
		}
		
		ToolbarItem(placement: .topBarTrailing) {
		    Button{
			showingUnitSheet.toggle()
		    } label: {
			Image(systemName: "ruler")
		    }
		}
	    }
	    .sheet(isPresented: $showingUnitSheet) {
		UnitView()
		    .presentationDetents([.fraction(0.35)])
	    }
	}
    }
}

#Preview {
    FilterView(minVelocity: .constant(10.0), minDiameter: .constant(11.0), minMagnitude: .constant(11))
}

extension FilterView {
    
    var velocityUnit: String {
	switch speedSelection {
	case .mph:
	    return "mph"
	case .kmPerS:
	    return "km/s"
	case .kmPerH:
	    return "km/hr"
	}
    }
    
    var diameterUnit: String {
	switch diameterSelection {
	case .feet:
	    return "feet"
	case .meters:
	    return "meters"
	case .kilometers:
	    return "km"
	case .miles:
	    return "miles"
	}
    }
    
    var velocityMax: Double {
	switch speedSelection {
	case .mph:
	    return 90_000
	case .kmPerS:
	    return 40
	case .kmPerH:
	    return 144_000
	}
    }
    
    var diameterMax: Double {
	switch diameterSelection {
	case .feet:
	    return 49_000
	case .meters:
	    return 15_000
	case .kilometers:
	    return 15
	case .miles:
	    return 10
	}
    }
}
