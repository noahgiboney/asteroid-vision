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
        VStack(alignment: .leading, spacing: 7) {
            Text(entry.date)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading) {
                Text("Miss Distance: \(entry.missDistance(for: units.distance))")
                Text("Traveling: \(entry.velocity(for: units.velocity))")
            }
            .font(.footnote)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CloseApproachView(entry: .example)
        .environment(UnitSettings())
}
