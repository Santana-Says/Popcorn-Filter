//
//  SelectionCell.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/18/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit

protocol SelectionCellDelegate: AnyObject {
	func movieSelected()
}

class SelectionCell: UICollectionViewCell {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var movieImg: UIImageView!
	
	//MARK: - Properties
	
	weak var moviedelegate: SelectionCellDelegate?
	
	//MARK: - IBActions
	
	@IBAction func movieSelectedAction(_ sender: Any) {
		moviedelegate?.movieSelected()
	}
	
	//MARK: - Helpers
	
	func configImg(from urlString: String?) {
		if let urlString = urlString, let url = URL(string: urlString){
			movieImg.load(url: url)
		}
	}
}
