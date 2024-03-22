//
//  Dates.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation
import SwiftUI

extension Date {
    
    var todayDate: String {
	let formatter = DateFormatter()
	formatter.dateFormat = "yyyy-MM-dd"
	return formatter.string(from: self)
    }
    
    var shortDate: String {
	let formatter = DateFormatter()
	formatter.dateFormat = "M/d"
	return formatter.string(from: self)
    }
}

extension String {
    
    var formattedDate: String {
	let inputFormatter = DateFormatter()
	inputFormatter.dateFormat = "yyyy-MM-dd"
	
	guard let date = inputFormatter.date(from: self) else {
	    return "Unknown Date"
	}
	
	let outputFormatter = DateFormatter()
	outputFormatter.dateFormat = "M/d/yy"
	
	return outputFormatter.string(from: date)
    }
    
    var beforeDecimal: String {
	return self.components(separatedBy: ".").first ?? self
    }
}

extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
	let uiColor = UIColor(color)
	UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
	UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
	return self
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
	let formatter = NumberFormatter()
	let number = NSNumber(value: self)
	formatter.minimumFractionDigits = 0
	formatter.maximumFractionDigits = 16 
	return String(formatter.string(from: number) ?? "")
    }
}
