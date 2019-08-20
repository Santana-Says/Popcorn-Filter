//
//  SelectionController.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 8/19/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

enum NetworkError: Error {
	case badURL
	case noToken
	case noData
	case notDecoding
	case notEncoding
	case other(Error)
}

class SelectionController {
	
	private var movies = Set<MovieDetails>()
	private var defaultSession = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	private let baseURL = URL(string: "https://tv-v2.api-fetch.website")!
	private var dataPage = 1
	
	func getMovies() -> [MovieDetails] {
		var movies = Array(self.movies)
		
		movies = movies.filter { (movie) -> Bool in
			guard let percentage = movie.rating?.percentage else {return false}
			return percentage >= 75
		}
		movies.sort(by: { (m1, m2) -> Bool in
			return m1.rating?.percentage ?? 0 > m2.rating?.percentage ?? 0
		})
		
		return Array(movies)
	}
	
	func loadMovies(of category: Category, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
		dataTask?.cancel()
		let moviesURL = baseURL.appendingPathComponent(category.rawValue)
			.appendingPathComponent(String(dataPage))
		
		defaultSession.dataTask(with: moviesURL) { (data, response, error) in
			if let error = error {
				if let response = response as? HTTPURLResponse, response.statusCode != 200 {
					NSLog("Error: status code is \(response.statusCode) instead of 200.")
				}
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				self.movies = try Set(JSONDecoder().decode([MovieDetails].self, from: data))
				completion(.success(true))
			} catch {
				completion(.failure(.notDecoding))
			}
		}.resume()
	}
}
