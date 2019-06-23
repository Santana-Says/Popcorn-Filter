//
//  SelectionVC.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/18/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit

enum Category: String {
	case movie = "movies"
	case show = "shows"
}

class SelectionVC: UIViewController {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	private var movieData: [MovieDetails]?	
	var category: Category?
	
	//MARK: - Properties
	
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		retreiveData()
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func buildURL() -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "tv-v2.api-fetch.website"
		if let category = category {
			components.path = "/\(category.rawValue)/1"
		}
		
		return components.url
	}
	
	private func retreiveData() {
		guard let url = buildURL() else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			print("Doing Something")
			if let data = data {
				do {
					self.movieData = try JSONDecoder().decode([MovieDetails].self, from: data)
				} catch let err {
					print("Error serrializing error", err)
				}
			}
		}.resume()
	}

}
