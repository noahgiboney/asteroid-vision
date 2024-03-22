//
//  NearEarthObjectsByData.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

struct NearEarthObjectsByData: Codable{
    
    let objects: [NearEarthObject]
    
    struct DynamicCodingKeys: CodingKey {
	    var stringValue: String
	    var intValue: Int?
	    
	    init?(stringValue: String) {
		self.stringValue = stringValue
	    }
	    
	    init?(intValue: Int) {
		self.intValue = intValue
		self.stringValue = "\(intValue)"
	    }
	    
	    static func keyForToday() -> DynamicCodingKeys {
		return DynamicCodingKeys(stringValue: Date().todayDate)!
	    }
	}
    
    init(from decoder: Decoder) throws {
	let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
	let todayKey = DynamicCodingKeys.keyForToday()
	
	self.objects = try container.decode([NearEarthObject].self, forKey: todayKey)
    }
}
