//
//  MainController.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController, APITwitterDelegate {
	var service: TweetService?
	var tweets: [Tweet]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Tweets"
		view.backgroundColor = .white
		DataService.shared.getToken { token in
			guard let token = token else { return }
			self.service = TweetService(token: token, delegate: self)
			self.service?.search("ecole 42")
		}
	}
	
	func handle(tweets: [Tweet]) {
		self.tweets = tweets
	}
	
	func handle(error: Error) {
		print(error)
	}
}

