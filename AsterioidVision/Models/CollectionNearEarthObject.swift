//
//  CollectionNearEarthObject.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

struct CollectionNearEarthObject: Codable, Identifiable {
    let id: String
    var neoReferenceId: String
    var name: String
    var nameLimited: String
    var absoluteMagnitudeH: Double
    var estimatedDiameter: EstimatedDiameter
    var isPotentiallyHazardousAsteroid: Bool
    var closeApproachData: [CloseApproachData]
    var orbitalData: OrbitData
}
