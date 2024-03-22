//
//  Dates.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

extension String {
    
    static func todayDate() -> String {
	let formatter = DateFormatter()
	formatter.dateFormat = "yyyy-MM-dd"
	return formatter.string(from: Date())
    }
    
    static func formattedDate(_ dateString: String) -> String {
	let inputFormatter = DateFormatter()
	inputFormatter.dateFormat = "yyyy-MM-dd"
	
	guard let date = inputFormatter.date(from: dateString) else {
	    return "Unknown Date"
	}
	
	let outputFormatter = DateFormatter()
	outputFormatter.dateFormat = "M/d/yy"
	
	return outputFormatter.string(from: date)
    }
    
}

extension String {
    var beforeDecimal: String {
	return self.components(separatedBy: ".").first ?? self
    }
}
