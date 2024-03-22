//
//  SightingRow.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/21/24.
//

import SwiftUI

struct SightingRow: View {
    
    var closeApproach: CloseApproachData
    
    var body: some View {
	Group {
	    HStack{
		Spacer()
		    VStack{
			Text(closeApproach.date).bold()
		    }
		Spacer()
		    VStack{
			Text("Orbiting Body").font(.caption.bold())
			Text(closeApproach.orbitingBody)
		    }
		Spacer()
		    VStack{
			Text("Relative Velocity").font(.caption.bold())
			Text(closeApproach.relativeVelocity.kms)
		    }
		Spacer()
		}
	}
    }
}

#Preview {
    SightingRow(closeApproach: CloseApproachData.example)
}
