//
//  MovieDetails.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/18/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import Foundation

struct MovieDetails: Codable, Hashable {
	var title:				String?
	var year:				String?
	var synopsis:			String?
	var runtime: 			String?
	var trailer:			String?
	var certification:		String?
	var genres:				[String]?
	var images:				MovieImages?
	var rating:				MovieReview?
	
//	enum codingKeys: String, CodingKey {
//		case title
//		case year
//		case synopsis
//		case runtime
//		case trailer
//		case rated = "certification"
//		case images
//		case review = "rating"
//	}
	
}

struct MovieImages: Codable, Hashable {
	var poster:	String?
	var fanart: String?
	var banner:	String?
}

struct MovieReview: Codable, Hashable {
	var percentage:	Int?
	var votes:		Int?
}
