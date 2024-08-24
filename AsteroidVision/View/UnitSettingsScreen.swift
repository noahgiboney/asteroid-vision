//
//  UnitSettingsScreen.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/27/24.
//

import SwiftUI

struct UnitSettingsScreen: View {
    @Bindable var units: UnitSettings
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Units") {
                    Picker(selection: $units.velocity) {
                        ForEach(Velocity.allCases, id: \.self) { speed in
                            Text(speed.prefix)
                                .tag(speed)
                        }
                    } label: {
                        Label("Relative Velocity", systemImage: "gauge.open.with.lines.needle.33percent")
                    }
                    
                    Picker(selection: $units.diameter) {
                        ForEach(Diameter.allCases, id: \.self) { diameter in
                            Text(diameter.prefix)
                                .tag(diameter)
                        }
                    } label: {
                        Label("Estimated Diameter", systemImage: "ruler")
                    }
                    
                    Picker(selection: $units.distance) {
                        ForEach(Distance.allCases, id: \.self) { distance in
                            Text(distance.prefix)
                                .tag(distance)
                        }
                    } label: {
                        Label("Miss Distance", systemImage: "ruler")
                    }
                }
            }
            .navigationTitle("Unit Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UnitSettingsScreen(units: UnitSettings())
    }
}
