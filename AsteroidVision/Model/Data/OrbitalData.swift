//
//  OrbitData.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

struct OrbitalData: Codable, Hashable {
    let orbitId: String
    let orbitDeterminationDate: String
    let firstObservationDate: String
    let lastObservationDate: String
    
    static let example = OrbitalData(orbitId: "659", orbitDeterminationDate: "2021-05-24 17:55:05", firstObservationDate: "1893-10-29", lastObservationDate: "2021-05-13")
}


