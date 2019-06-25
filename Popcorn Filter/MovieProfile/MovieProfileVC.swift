//
//  MovieProfileVC.swift
//  Popcorn Filter
//
//  Created by Jeffrey Santana on 6/23/19.
//  Copyright © 2019 Jefffrey Santana. All rights reserved.
//

import UIKit

class MovieProfileVC: UIViewController {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var bannerImg: UIImageView!
	@IBOutlet weak var profileImg: UIImageView!
	@IBOutlet weak var synopsisLbl: UILabel!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var yearLbl: UILabel!
	@IBOutlet weak var ratingLbl: UILabel!
	@IBOutlet weak var durationLbl: UILabel!
	@IBOutlet weak var genresLbl: UILabel!
	
	//MARK: - Properties
	
	var mediaDetails: MovieDetails?
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configViews()
	}
	
	//MARK: - IBActions
	
	@IBAction func backButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	//MARK: - Helpers
	
	private func configProfileImg() {
		let newFrame = bannerImg.frame.width * 0.5
		profileImg.frame.size = CGSize(width: newFrame, height: newFrame)
		profileImg.center = CGPoint(x: bannerImg.center.x, y: bannerImg.frame.maxY)
		profileImg.layer.cornerRadius = profileImg.frame.width / 2
		profileImg.clipsToBounds = true
		profileImg.layer.borderWidth = 2
		profileImg.layer.borderColor = profileImg.backgroundColor?.cgColor
	}
	
	private func setDuration() -> String {
		guard let runtime = mediaDetails?.runtime, let totalMinutes = Double(runtime) else { return ""}
		let perHour = 60.0
		let duration = String(totalMinutes / perHour)
		let durationComponents = duration.components(separatedBy: ".")
		let hours = durationComponents[0]
		let minutes = durationComponents[1]
		
		return "\(hours)h \(minutes)min"
	}
	
	func configViews() {
		configProfileImg()
		
		if let url = mediaDetails?.images?.fanart, let bannerURL = URL(string: url) {
			bannerImg.load(url: bannerURL)
		}
		if let url = mediaDetails?.images?.poster, let posterURL = URL(string: url) {
			profileImg.load(url: posterURL)
		}
		titleLbl.text = mediaDetails?.title
		yearLbl.text = mediaDetails?.year
		ratingLbl.text = mediaDetails?.certification
		durationLbl.text = setDuration()
		if let genres = mediaDetails?.genres {
			genresLbl.text = genres.joined(separator: ", ")
		}
		synopsisLbl.text = mediaDetails?.synopsis
	}

}
