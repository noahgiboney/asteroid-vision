//
//  CloseApproachCard.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import SwiftUI

struct CloseApproachView: View {
    var entry: CloseApproachData
    @Environment(UnitSettings.self) var units
  
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("Miss Distance: \(entry.missDistance(for: units.distance))")
                Text("Traveling: \(entry.velocity(for: units.velocity))")
            }
            
            Spacer()
            
            Text(entry.date)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CloseApproachView(entry: .example)
        .environment(UnitSettings())
}
