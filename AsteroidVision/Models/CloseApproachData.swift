//
//  CloseApproachData.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

struct CloseApproachData: Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: String
    
    static let example = CloseApproachData(closeApproachDate: "2029-09-08", closeApproachDateFull: "2029-Sep-08 20:28", epochDateCloseApproach: 1441744080000, relativeVelocity: RelativeVelocity.example, missDistance: MissDistance.example, orbitingBody: "Earth")
    
    var date: String {
	closeApproachDate.formattedDate
    }
    
    var approachDate: Date? {
	let formatter = DateFormatter()
	formatter.dateFormat = "yyyy-MM-dd"
	return formatter.date(from: closeApproachDate)
    }
}

struct RelativeVelocity: Codable{
    let kilometersPerSecond: String
    let kilometersPerHour: String
    let milesPerHour: String
    
    static let example = RelativeVelocity(kilometersPerSecond: "18.1279360862", kilometersPerHour: "65260.5699103704", milesPerHour: "40550.3802312521")
    
    var kms: String {
	return kilometersPerSecond.beforeDecimal + " km/s"
    }
}

struct MissDistance: Codable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
    
    var km: String {
	return kilometers.beforeDecimal + " km"
    }
    
    static let example = MissDistance(astronomical: "0.3027469457", lunar: "117.7685618773", kilometers: "45290298.225725659", miles: "28142086.3515817342")
}
