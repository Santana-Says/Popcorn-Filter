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
	private var selectController = SelectionController()
	weak var cellDelegate: SelectionCellDelegate?
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	init(moviesView: UICollectionView, category cat: Category?) {
		collectionView = moviesView
		category = cat ?? .movie
	}
	
	func retreiveData() {
		selectController.loadMovies(of: Category.movie) { (result) in
			guard let _ = try? result.get() else { return }
			
			DispatchQueue.main.async {
				self.movieData = self.selectController.getMovies()
				self.collectionView?.reloadData()
			}
		}
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
		let cellsPerRow: CGFloat = 2
		let sumOfSpaces = cellSpace * cellsPerRow
		let cellWidth = (collectionView.bounds.width - sumOfSpaces) / cellsPerRow
		
		return CGSize(width: cellWidth, height: cellWidth * 1.3)
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.row == (movieData.count - 5) {
			dataPage += 1
			retreiveData()
		}
	}
}
