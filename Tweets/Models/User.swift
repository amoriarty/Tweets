//
//  User.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 16/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

struct User: Decodable {
	let name: String
	let screenName: String
	let imageUrl: String
	
	private enum CodingKeys: String, CodingKey {
		case name
		case screenName = "screen_name"
		case imageUrl = "profile_image_url"
	}
}
