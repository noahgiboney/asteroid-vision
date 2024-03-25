//
//  EstimatedDiameter.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

struct EstimatedDiameter: Codable {
    let kilometers: Kilometers
    let meters: Meters
    let miles: Miles
    let feet: Feet
    
    
    static let example = EstimatedDiameter(kilometers: Kilometers.example, meters: Meters.example, miles: Miles.example, feet: Feet.example)
}

struct Kilometers: Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    static let example = Kilometers(estimatedDiameterMin: 217.0475943071, estimatedDiameterMax: 485.3331752235)
    
    var diameter: String {
	return ((estimatedDiameterMax + estimatedDiameterMin) / 2).rounded().removeZerosFromEnd()
    }
}

struct Meters: Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    static let example = Meters(estimatedDiameterMin: 217.0475943071, estimatedDiameterMax: 485.3331752235)
    
    var diameter: String {
	return ((estimatedDiameterMax + estimatedDiameterMin) / 2).rounded().removeZerosFromEnd()
    }
}

struct Miles: Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    static let example = Miles(estimatedDiameterMin: 217.0475943071, estimatedDiameterMax: 485.3331752235)
    
    var diameter: String {
	return ((estimatedDiameterMax + estimatedDiameterMin) / 2).rounded().removeZerosFromEnd()
    }
}

struct Feet: Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    static let example = Feet(estimatedDiameterMin: 217.0475943071, estimatedDiameterMax: 485.3331752235)
    
    var diameter: String {
	return ((estimatedDiameterMax + estimatedDiameterMin) / 2).rounded().removeZerosFromEnd()
    }
}
