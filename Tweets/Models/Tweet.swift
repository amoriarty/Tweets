//
//  Tweet.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible, Decodable {
	let user: User
	let text: String
	var description: String {
		return "@\(user.screenName): \(text)"
	}
}
