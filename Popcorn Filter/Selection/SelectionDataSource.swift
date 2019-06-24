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
		components.path = "/\(category.rawValue)/1"
		
		return components.url
	}
	
	func retreiveData() {
		guard let url = buildURL() else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			print("Grabbing data")
			if let data = data {
				do {
					self.movieData = try JSONDecoder().decode([MovieDetails].self, from: data)
					print("Decoded")
					DispatchQueue.main.async {
						self.collectionView?.reloadData()
					}
				} catch let err {
					print("Error serrializing error", err)
				}
			}
		}.resume()
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
			
			cell.configImg(from: data.images?.poster)
			
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
}
