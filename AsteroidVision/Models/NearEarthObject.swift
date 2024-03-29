//
//  CollectionNearEarthObject.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

struct NearEarthObject: Codable, Identifiable, Equatable {
    let id: String
    var neoReferenceId: String
    let name: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachData]
    let orbitalData: OrbitalData
    
    static func ==(lhs: NearEarthObject, rhs: NearEarthObject) -> Bool{
	lhs.id == rhs.id
    }
    
    var closestApproach: String? {
	let now = Date()
	let futureCloseApproachData = self.closeApproachData.filter { data -> Bool in
	    guard let approachDate = data.approachDate else {
		return false
	    }
	    return approachDate > now
	}
	let closestFutureApproachData = futureCloseApproachData.min(by: { (data1, data2) -> Bool in
	    guard let date1 = data1.approachDate, let date2 = data2.approachDate else {
		return false
	    }
	    return date1.timeIntervalSince(now) < date2.timeIntervalSince(now)
	})
	return closestFutureApproachData?.closeApproachDate
    }
    
    static let example = NearEarthObject(id: "666", neoReferenceId: "84434", name: "234234 (2019 Junipt)", absoluteMagnitudeH: 44.1, estimatedDiameter: EstimatedDiameter.example, isPotentiallyHazardousAsteroid: false, closeApproachData: Array<CloseApproachData>.init(repeating: CloseApproachData.example, count: 10), orbitalData: OrbitalData.example)
}
