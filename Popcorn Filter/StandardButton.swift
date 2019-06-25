//
//  StandardButton.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/24/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit
@IBDesignable
class StandardButton: UIButton {
	
	override func prepareForInterfaceBuilder() {
		customizeView()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		customizeView()
	}
	
	func customizeView() {
		tintColor = .black
		backgroundColor = .white
		layer.cornerRadius = 10.0
	}
	
}
