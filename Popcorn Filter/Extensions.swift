//
//  Extensions.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/23/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit

extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
