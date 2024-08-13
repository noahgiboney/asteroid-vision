//
//  Unit.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

enum Distance: String, CaseIterable, Codable {
    case kilometers, miles, lunar, astronomical
    
    var prefix: String {
        switch self {
        case .kilometers:
            "km"
        case .miles:
            "mi"
        case .lunar:
            "lunar"
        case .astronomical:
            "au"
        }
    }
}

enum Velocity: String, CaseIterable, Codable {
    case kmPerS, kmPerH, mph
    
    var prefix: String {
        switch self {
        case .kmPerS:
            "km/s"
        case .kmPerH:
            "km/hr"
        case .mph:
            "mph"
        }
    }
    
    var max: Double {
        switch self {
        case .mph:
            return 90_000
        case .kmPerS:
            return 40
        case .kmPerH:
            return 144_000
        }
    }
}

enum Diameter: String, CaseIterable, Codable {
    case kilometers, meters, miles, feet
    
    var prefix: String {
        switch self {
        case .kilometers:
            "km"
        case .meters:
            "m"
        case .miles:
            "mi"
        case .feet:
            "ft"
        }
    }
    
    var max: Double {
        switch self {
        case .feet:
            return 49_000
        case .meters:
            return 15_000
        case .kilometers:
            return 15
        case .miles:
            return 10
        }
    }
}
