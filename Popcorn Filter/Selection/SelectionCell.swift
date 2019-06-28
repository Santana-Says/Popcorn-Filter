//
//  SelectionCell.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/18/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit

protocol SelectionCellDelegate: AnyObject {
	func open(media: MovieDetails)
}

class SelectionCell: UICollectionViewCell {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var movieImg: UIImageView!
	@IBOutlet weak var scoreLbl: UILabel!
	
	//MARK: - Properties
	
	weak var moviedelegate: SelectionCellDelegate?
	private var details: MovieDetails?
	
	//MARK: - IBActions
	
	@IBAction func movieSelectedAction(_ sender: Any) {
		guard let details = details else { return }
		moviedelegate?.open(media: details)
	}
	
	//MARK: - Helpers
	
	func config(data: MovieDetails) {
		details = data
		setImg(from: data.images?.poster)
		if let percentage = data.rating?.percentage, let votes = data.rating?.votes {
			scoreLbl.text = "\(percentage)% (\(votes))"
		} else {
			scoreLbl.text = "No votes"
		}
	}
	
	private func setImg(from urlString: String?) {
		if let urlString = urlString, let url = URL(string: urlString){
			movieImg.load(url: url)
		}
	}
}
