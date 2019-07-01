//
//  SelectionDataSource.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/23/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit

class SelectionDataSource: NSObject {
	
	//MARK: - IBOutlets
	
	
	//MARK: - Properties
	
	private var collectionView: UICollectionView?
	private var dataPage = 1
	private var movieData = [MovieDetails]()
	private var category: Category
	weak var cellDelegate: SelectionCellDelegate?
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	init(moviesView: UICollectionView, category cat: Category?) {
		collectionView = moviesView
		category = cat ?? .movie
	}
	
	private func buildURL() -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "tv-v2.api-fetch.website"
		components.path = "/\(category.rawValue)/\(dataPage)"
		components.queryItems = [
			URLQueryItem(name: "sort", value: "year")
		]
		
		return components.url
	}
	
	private func removeDuplicates(content: [MovieDetails]) -> [MovieDetails] {
		var movies = [MovieDetails]()
		for movie in content {
			if !self.movieData.contains(where: {$0.title == movie.title}) {
				movies.append(movie)
			}
		}
		return movies
	}
	
	func retreiveData() {
		guard let url = buildURL() else { return }
		
		print(url.absoluteString)
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let data = data {
				do {
					var rawMovieData = try JSONDecoder().decode([MovieDetails].self, from: data)
					print("Movie count: \(self.movieData.count)")
					rawMovieData = rawMovieData.filter({ (movie) -> Bool in
						guard let percentage = movie.rating?.percentage else {return false}
						return percentage >= 75
					})
					
					let newMovies = self.removeDuplicates(content: rawMovieData)
					self.movieData.append(contentsOf: newMovies)
					print("Movie count: \(self.movieData.count)")
					DispatchQueue.main.async {
						self.collectionView?.reloadData()
					}
				} catch let err {
					print("Error serrializing error", err)
				}
			}
		}.resume()
		
		movieData.sort(by: { (m1, m2) -> Bool in
			return m1.rating?.percentage ?? 0 > m2.rating?.percentage ?? 0
		})
	}

}

//MARK: - CollectionView

extension SelectionDataSource: UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return movieData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCell", for: indexPath) as? SelectionCell {
			let data = movieData[indexPath.row]
			
			cell.config(data: data)
			cell.moviedelegate = cellDelegate
			
			return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellSpace: CGFloat = 7
		let cellsPerRow: CGFloat = 3
		let sumOfSpaces = cellSpace * cellsPerRow
		let cellWidth = (collectionView.bounds.width - sumOfSpaces) / cellsPerRow
		
		return CGSize(width: cellWidth, height: cellWidth * 1.3)
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.row == (movieData.count - 1) {
			dataPage += 1
			retreiveData()
		}
	}
}
