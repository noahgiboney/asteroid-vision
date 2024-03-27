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
    
    var list: Array<CollectionNearEarthObject> {
	didSet {
	    let data = try? JSONEncoder().encode(list)
	    UserDefaults.standard.setValue(data, forKey: key)
	}
    }
    
    init() {
	
	if let data = UserDefaults.standard.data(forKey: key) {
	    
	    do {
		list = try JSONDecoder().decode([CollectionNearEarthObject].self, from: data)
		return
	    } catch {
		print(error.localizedDescription)
	    }
	}
	list = []
    }
    
    func contains(_ item: CollectionNearEarthObject) -> Bool{
	list.contains(item)
    }
    
    func add(_ item: CollectionNearEarthObject) {
	list.append(item)
    }
    
    func delete(_ item: CollectionNearEarthObject) {
	list.removeAll { itemID in
	    item == itemID
	}
    }
    
    func deleteAt(offset: IndexSet) {
	list.remove(atOffsets: offset)
    }
    
}
