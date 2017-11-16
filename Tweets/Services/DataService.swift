//
//  DataService.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

let TOKEN_URL = "https://api.twitter.com/oauth2/token"
var BEARER: String? {
	guard let data = "\(CONSUMER_KEY):\(CONSUMER_SECRET)".data(using: .utf8) else { return nil }
	let base64 =  data.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0))
	return String(data: base64, encoding: .utf8)
}

class DataService {
	static let shared = DataService()
	
	func get<T: Decodable>(request: URLRequest, for type: T.Type, completion: @escaping (T?) -> Void) {
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard error == nil else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			guard let data = data else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			guard let result = try? JSONDecoder().decode(T.self, from: data) else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			completion(result)
		}.resume()
	}
	
	func getToken(completion: @escaping (String?) -> Void) {
		guard let bearer = BEARER else { return }
		guard let url = URL(string: TOKEN_URL) else { return }
		var request = URLRequest(url: url)
		
		request.httpMethod = "POST"
		request.setValue("Basic \(bearer)", forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded;charset=UTF-8.", forHTTPHeaderField: "Content-Type")
		request.httpBody = "grant_type=client_credentials".data(using: .utf8)
		DataService.shared.get(request: request, for: [String:String].self) { data in
			guard let data = data else {
				completion(nil)
				return
			}
			guard let token = data["access_token"] else {
				completion(nil)
				return
			}
			completion(token)
		}
	}
}
