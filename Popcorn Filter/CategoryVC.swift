//
//  CategoryVC.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/18/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
	
	//MARK: - IBOutlets
	
	
	//MARK: - Properties
	
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	//MARK: - IBActions
	
	@IBAction func categoryBtnAction(_ sender: UIButton) {
		let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionVC") as! SelectionVC
		if let title = sender.titleLabel?.text?.lowercased() {
			selectionVC.category = Category(rawValue: title)
		}
		present(selectionVC, animated: true, completion: nil)
	}
	
	//MARK: - Helpers	



}

