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
    
    static let example = NearEarthObject(id: "2465633", name: "465633 (2009 JR5)", absoluteMagnitudeH: 20.44, isPotentiallyHazardousAsteroid: true, isSentryObject: false, closeApproachData: [CloseApproachData.example], estimatedDiameter: EstimatedDiameter.example)
}

struct EstimatedDiameter: Codable {
    let meters: Meters
    
    static let example = EstimatedDiameter(meters: Meters.example)
}

struct Meters: Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    static let example = Meters(estimatedDiameterMin: 217.0475943071, estimatedDiameterMax: 485.3331752235)
}

struct CloseApproachData: Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: String
    
    static let example = CloseApproachData(closeApproachDate: "2015-09-08", closeApproachDateFull: "2015-Sep-08 20:28", epochDateCloseApproach: 1441744080000, relativeVelocity: RelativeVelocity.example, missDistance: MissDistance.example, orbitingBody: "Earth")
}

struct RelativeVelocity: Codable{
    let kilometersPerSecond: String
    let kilometersPerHour: String
    let milesPerHour: String
    
    static let example = RelativeVelocity(kilometersPerSecond: "18.1279360862", kilometersPerHour: "65260.5699103704", milesPerHour: "40550.3802312521")
    
}

struct MissDistance: Codable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
    
    static let example = MissDistance(astronomical: "0.3027469457", lunar: "117.7685618773", kilometers: "45290298.225725659", miles: "28142086.3515817342")
}


