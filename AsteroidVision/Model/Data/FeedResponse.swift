//
//  FeedResponse.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/23/24.
//

import Foundation

struct FeedResponse: Decodable {
    let nearEarthObjects: [String : [NearEarthObject]]
}

