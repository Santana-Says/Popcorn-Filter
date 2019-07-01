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
	@IBOutlet weak var screenLbl: UILabel!
	
	var category: Category?
	private lazy var selectionDataSource: SelectionDataSource = {
		let datasource = SelectionDataSource(moviesView: self.collectionView, category: self.category)
		datasource.cellDelegate = self
		return datasource
	}()
	
	//MARK: - Properties
	
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.delegate = selectionDataSource
		collectionView.dataSource = selectionDataSource
		
		selectionDataSource.retreiveData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
	}
	
	//MARK: - IBActions
	
	@IBAction func backButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	//MARK: - Helpers

}

//MARK: - Cell Delegate

extension SelectionVC: SelectionCellDelegate {
	func open(media: MovieDetails) {
		if let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? MovieProfileVC {
			profileVC.mediaDetails = media
			present(profileVC, animated: true, completion: nil)
		}
	}
}
