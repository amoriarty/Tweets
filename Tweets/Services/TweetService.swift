//
//  TweetService.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

let SEARCH_URL = "https://api.twitter.com/1.1/search/tweets.json"

protocol APITwitterDelegate: class {
	func handle(tweets: [Tweet])
	func handle(error: Error)
}

class TweetService {
	weak var delegate: APITwitterDelegate?
	private let token: String
	
	struct SearchResponse: Decodable {
		let statuses: [Tweet]
	}
	
	init(token: String, delegate: APITwitterDelegate?) {
		self.token = token
		self.delegate = delegate
	}
	
	func search(_ text: String, count: Int = 100, lang: String = "fr") {
		guard text != "" else { return }
		guard let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
		guard let url = URL(string: "\(SEARCH_URL)?lang=\(lang)&count=\(count)&q=\(text)") else { return }
		var request = URLRequest(url: url)
		
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded;charset=UTF-8.", forHTTPHeaderField: "Content-Type")
		DataService.shared.get(request: request, for: SearchResponse.self) { data in
			guard let data = data else { return }
			self.delegate?.handle(tweets: data.statuses)
		}
	}
}
