//
//  NearEarthObject.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

struct NearEarthObject: Codable, Identifiable {
    let id: String
    let name: String
    let absoluteMagnitudeH: Double
    let isPotentiallyHazardousAsteroid: Bool
    let isSentryObject: Bool
    let closeApproachData: [CloseApproachData]
    let estimatedDiameter: EstimatedDiameter
    
    static let example = NearEarthObject(id: "2465633", name: "465633 (2009 JR5)", absoluteMagnitudeH: 20.44, isPotentiallyHazardousAsteroid: true, isSentryObject: false, closeApproachData: Array<CloseApproachData>.init(repeating: CloseApproachData.example, count: 10), estimatedDiameter: EstimatedDiameter.example)
}

