//
//  MovieDetails.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/18/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
	var title:		String?
	var year:		String?
	var synopsis:	String?
	var runtime: 	String?
	var trailer:	String?
	var rated:		String?
	var images:		MovieImages?
	var review:		MovieReview?
	
	enum codingKeys: String, CodingKey {
		case title
		case year
		case synopsis
		case runtime
		case trailer
		case rated = "certification"
		case images
		case review = "rating"
	}
	
}

struct MovieImages: Codable {
	var poster:	String?
	var fanart: String?
	var banner:	String?
}

struct MovieReview: Codable {
	var percentage:	Int?
	var votes:		Int?
}
