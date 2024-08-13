//
//  CollectionResponse.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

struct Response: Codable, Hashable {
    var nearEarthObjects: [NearEarthObject]
}
