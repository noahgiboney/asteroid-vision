//
//  NetworkManager.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation

@Observable
class NetworkService {
    
    private let key = "dHOF8WnJtWYZrknUvPJZRddyB7J7q537zUXdwodN"

    var error: Error?
    
    func fetchAsteroids() async throws -> Response?{
	
	let url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2015-09-07&end_date=2015-09-08&api_key=\(key)"
	
	do {
	    guard let endpoint = URL(string: url) else { throw NasaError.url }
	    
	    let (data, serverResponse) = try await URLSession.shared.data(from: endpoint)
	    
	    guard (serverResponse as? HTTPURLResponse)?.statusCode == 200 else { throw NasaError.server }
	    
	    let decoder = JSONDecoder()
	    decoder.keyDecodingStrategy = .convertFromSnakeCase
	    
	    guard let decodedData = try? decoder.decode(Response.self, from: data) else {
		throw NasaError.data
	    }
	    return decodedData
	} catch {
	    self.error = error
	}
	return nil
    }
}
