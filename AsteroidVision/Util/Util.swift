//
//  Util.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation
import SwiftUI

extension String {
    var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else {
            return "Unknown Date"
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "M/d/yyyy"
        
        return outputFormatter.string(from: date)
    }
    
    var beforeDecimal: String {
        return self.components(separatedBy: ".").first ?? self
    }
    
    func roundedDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        guard let numberValue = Double(self) else { return "" }
        let number = NSNumber(value: numberValue)
        
        return formatter.string(from: number) ?? ""
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
    func roundedDecimal() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return String(formatter.string(from: number) ?? "")
    }
    
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        return String(formatter.string(from: number) ?? "")
    }
}
