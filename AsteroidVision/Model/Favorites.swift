//
//  Favorites.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import Foundation


@Observable
class Favorites {
    private let key = "favorites"
    
    var favorites = Set<String>() {
        didSet {
           save()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                favorites = try JSONDecoder().decode(Set<String>.self, from: data)
                return
            } catch {
                print(error.localizedDescription)
            }
        }
        favorites = []
    }
    
    private func save() {
        let data = try? JSONEncoder().encode(favorites)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
    func contains(_ item: String) -> Bool {
        favorites.contains(item)
    }
    
    func add(_ item: String) {
        favorites.insert(item)
    }
    
    func delete(_ item: String) {
        favorites.remove(item)
    }
    
    func onDelete(at offsets: IndexSet) {
        let array = Array(favorites)
    
        for index in offsets {
            let elementToRemove = array[index]
            favorites.remove(elementToRemove)
        }
    }
}
