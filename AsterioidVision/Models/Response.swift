//
//  Asteriod.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/16/24.
//

import Foundation

struct Response: Codable {
    var elementCount: Int
    var nearEarthObjects: NearEarthObjectsByData
}
