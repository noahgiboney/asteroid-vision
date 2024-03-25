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
    
    var list: Array<String> {
	didSet {
	    let data = try? JSONEncoder().encode(list)
	    UserDefaults.standard.setValue(data, forKey: key)
	}
    }
    
    init() {
	
	if let data = UserDefaults.standard.data(forKey: key) {
	    
	    do {
		list = try JSONDecoder().decode([String].self, from: data)
		return
	    } catch {
		print(error.localizedDescription)
	    }
	}
	list = []
    }
    
    func contains(_ str: String) -> Bool{
	list.contains(str)
    }
    
    func add(_ id: String) {
	list.append(id)
    }
    
    func delete(_ id: String) {
	list.removeAll { itemID in
	    itemID == id
	}
    }
    
    func deleteAt(offset: IndexSet) {
	list.remove(atOffsets: offset)
    }
    
}
