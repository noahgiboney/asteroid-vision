//
//  ContentView.swift
//  AsterioidVision
//
//  Created by Noah Giboney on 3/16/24.
//

import SwiftUI

struct ContentView: View {
    
    enum ApiErrors: Error {
	case url, response
    }
    
    @State private var asteriods: [NearEarthObject] = []
    
    var body: some View {
	
	NavigationStack {
	    List(asteriods) { asteroid in
		Text(asteroid.name)
	    }
	}
	.task {
	    do {
		try await fetchAsteriods()
		
	    } catch ApiErrors.url {
		print("url error")
	    }
	    catch ApiErrors.response {
		print("response error")
	    } catch {
		print("other error")
	    }
	}
    }
    
    func fetchAsteriods() async throws {
	
	let key = "dHOF8WnJtWYZrknUvPJZRddyB7J7q537zUXdwodN"
	
	let url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2015-09-07&end_date=2015-09-08&api_key=\(key)"
	
	guard let endpoint = URL(string: url) else {
	    throw ApiErrors.url
	}
	
	let (data, response) = try await URLSession.shared.data(from: endpoint)
	
	guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
	    throw ApiErrors.response
	}
	
	do {
	    
	    let decoder = JSONDecoder()
	    decoder.keyDecodingStrategy = .convertFromSnakeCase
	    
	    let decodedData = try decoder.decode(Response.self, from: data)
	    asteriods = decodedData.nearEarthObjects.objects.filter({ asteriod in
		asteriod.isPotentiallyHazardousAsteroid
	    })
	    
	} catch DecodingError.keyNotFound(let key, let context) {
	    print("failed to decode data due to missing key - '\(key)' - \(context.debugDescription)")
	} catch DecodingError.typeMismatch(_, let context) {
	    print("failed to decode data due to type mismatch - \(context.debugDescription)")
	} catch DecodingError.valueNotFound(let type, let context) {
	    print("failed to decode data due to missing \(type) value - \(context.debugDescription)")
	} catch DecodingError.dataCorrupted(_) {
	    print("failed to decode data data corrupted ")
	} catch {
	    print("failed to decode data \(error.localizedDescription)")
	}
	
    }
}

#Preview {
    ContentView()
}
