//
//  NearEarthObjectsByData.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

struct NearEarthObjectsByData: Codable{
    let objects: [NearEarthObject]
    
    enum CodingKeys: String, CodingKey {
	case objects = "2015-09-08"
    }
}
