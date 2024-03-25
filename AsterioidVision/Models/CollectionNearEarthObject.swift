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
//    var orbitalData: OrbitData
    
    static let example = CollectionNearEarthObject(id: "666", neoReferenceId: "84434", name: "234234 (2019 Junipt)", nameLimited: "Junipt", absoluteMagnitudeH: 44.1, estimatedDiameter: EstimatedDiameter.example, isPotentiallyHazardousAsteroid: false, closeApproachData: Array<CloseApproachData>.init(repeating: CloseApproachData.example, count: 10))
}
