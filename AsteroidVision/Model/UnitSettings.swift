//
//  UnitSettings.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 8/9/24.
//

import Foundation

@Observable
class UnitSettings {
    var velocity: Velocity {
        didSet {
            saveToUserDefaults(velocity, key: "velocity")
        }
    }
    
    var distance: Distance {
        didSet {
            saveToUserDefaults(distance, key: "distance")
        }
    }
    
    var diameter: Diameter {
        didSet {
            saveToUserDefaults(diameter, key: "diameter")
        }
    }
    
    init() {
        self.velocity = UnitSettings.retrieveUserDefault(key: "velocity") ?? .mph
        self.distance = UnitSettings.retrieveUserDefault(key: "distance") ?? .miles
        self.diameter = UnitSettings.retrieveUserDefault(key: "diameter") ?? .feet
    }
    
    func saveToUserDefaults<T: Codable> (_ unit: T, key: String) {
        do {
            let data = try JSONEncoder().encode(unit)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print("Error: saveToUserDefaults(): \(error.localizedDescription)")
        }
    }
    
    static func retrieveUserDefault<T: Codable>(key: String) -> T? {
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                return try JSONDecoder().decode(T.self, from: data)
            }
        } catch {
            print("Error: saveToUserDefaults(): \(error.localizedDescription)")
        }
        return nil
    }
}
