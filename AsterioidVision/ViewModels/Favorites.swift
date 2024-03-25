//
//  HomeViewModel.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import Foundation


@Observable
class Favorites {
    
    let key = "favorites"
    
    var favorites: Set<String> {
	didSet {
	    let data = try? JSONEncoder().encode(favorites)
	    UserDefaults.standard.setValue(data, forKey: key)
	}
    }
    
    init() {
	
	if let data = UserDefaults.standard.data(forKey: key) {
	    
	    do {
		favorites = try JSONDecoder().decode(Set<String>.self, from: data)
	    } catch {
		print(error.localizedDescription)
	    }
	}
	favorites = []
    }
    
    func contains(_ str: String) -> Bool{
	favorites.contains(str)
    }
    
    func add(_ id: String) {
	favorites.insert(id)
    }
    
    func delete(_ id: String) {
	favorites.remove(id)
    }
    
}
