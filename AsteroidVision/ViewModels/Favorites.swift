//
//  HomeViewModel.swift
//  AsteroidVision
//
//  Created by Noah Giboney on 3/24/24.
//

import Foundation


@Observable
class Favorites {
    
    let key = "favorites"
    
    var list: Array<NearEarthObject> {
	didSet {
	    let data = try? JSONEncoder().encode(list)
	    UserDefaults.standard.setValue(data, forKey: key)
	}
    }
    
    init() {
	
	if let data = UserDefaults.standard.data(forKey: key) {
	    
	    do {
		list = try JSONDecoder().decode([NearEarthObject].self, from: data)
		return
	    } catch {
		print(error.localizedDescription)
	    }
	}
	list = []
    }
    
    func contains(_ item: NearEarthObject) -> Bool{
	list.contains(item)
    }
    
    func add(_ item: NearEarthObject) {
	list.append(item)
    }
    
    func delete(_ item: NearEarthObject) {
	list.removeAll { itemID in
	    item == itemID
	}
    }
    
    func deleteAt(offset: IndexSet) {
	list.remove(atOffsets: offset)
    }
    
}
