//
//  SceneModel.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/8/24.
//

import Foundation

enum SceneModel {
    case earth, asteroid, pluto
    
    var resource: String {
        switch self {
        case .earth:
            return "earth.usdz"
        case .asteroid:
            return "asteroid.usdz"
        case .pluto:
            return "pluto.usdz"
        }
    }
}
