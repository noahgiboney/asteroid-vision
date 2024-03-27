//
//  NetworkManager.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/20/24.
//

import Foundation
import Observation

@Observable
class NetworkService {
    
    private let key = "dHOF8WnJtWYZrknUvPJZRddyB7J7q537zUXdwodN"
    
    private init() {}
    
    var error: Error?
    
    static let shared = NetworkService()
    
    func fetchNEO(for date: Date) async throws -> Response?{
	print(date);
	let url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(date.todayDate)&end_date=\(date.todayDate)&api_key=\(key)"
	print("fetching for ... \(date.todayDate)")
	
	do {
	    
	    guard let endpoint = URL(string: url) else { throw APIError.url }
	    
	    let (data, serverResponse) = try await URLSession.shared.data(from: endpoint)
	    
	    guard (serverResponse as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.server }
	    
	    let decoder = JSONDecoder()
	    decoder.keyDecodingStrategy = .convertFromSnakeCase
	    
	    guard let decodedData = try? decoder.decode(Response.self, from: data) else {
		throw APIError.data
	    }
	    
	}  catch APIError.url{
	    print("NEO: invalid url")
	} catch APIError.server {
	    print("NEO: server error")
	} catch APIError.data{
	    print("NEO: invalid data")
	}
	return nil
    }
    
    func fetchAsteroidSightings(for id: String) async throws -> NearEarthObject?{
	let url = "https://api.nasa.gov/neo/rest/v1/neo/\(id)?api_key=\(key)"
	
	do {
	    
	    guard let endpoint = URL(string: url) else { throw APIError.url }
	    
	    let (data, response) = try await URLSession.shared.data(from: endpoint)
	    
	    guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.server}
	    
	    let decoder = JSONDecoder()
	    decoder.keyDecodingStrategy = .convertFromSnakeCase
	    
	    guard let decodedData = try? decoder.decode(NearEarthObject.self, from: data) else { throw APIError.data}
	    
	    return decodedData
	    
	} catch APIError.url{
	    print("all approaches: invalid url")
	} catch APIError.server {
	    print("all approaches: server error")
	} catch APIError.data{
	    print("all approaches: invalid data")
	}
	return nil
    }
    
    func fetchAsteroidCollection(page: Int) async throws -> CollectionResponse? {
	
	let url = "https://api.nasa.gov/neo/rest/v1/neo/browse?page=\(page)&size=20&api_key=\(key)"
	
	do {
	    
	    guard let endpoint = URL(string: url) else {
		throw APIError.url
	    }
	    
	    let (data, response) = try await URLSession.shared.data(from: endpoint)
	    
	    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
		throw APIError.server
	    }
	    
	    let decoder = JSONDecoder()
	    decoder.keyDecodingStrategy = .convertFromSnakeCase
	    
	    guard let decodedData = try? decoder.decode(CollectionResponse.self, from: data) else {
		throw APIError.data
	    }
	    return decodedData
	    
	}  catch APIError.url{
	    print("collection: invalid url")
	} catch APIError.server {
	    print("collection: server error")
	} catch APIError.data{
	    print("collection: invalid data")
	}
	return nil
    }
}
