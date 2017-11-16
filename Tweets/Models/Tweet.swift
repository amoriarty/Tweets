//
//  Tweet.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

struct Tweet: CustomStringConvertible, Decodable {
	let user: User
	let text: String
	let createdAt: String
	var description: String {
		return "@\(user.screenName): \(text)"
	}
	
	var createdDate: String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US")
		formatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
		
		guard let date = formatter.date(from: createdAt) else { return createdAt }
		formatter.locale = Locale(identifier: "fr_FR")
		formatter.setLocalizedDateFormatFromTemplate("EEEE d MMM YYYY HH:mm")
		return formatter.string(from: date)
	}
	
	var attributed: NSAttributedString {
		let attributed = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
		let login = NSAttributedString(string: " @\(user.screenName)\n\(createdDate)\n", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.gray])
		let tweet = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 12)])
		
		attributed.append(login)
		attributed.append(tweet)
		return attributed
	}
	
	private enum CodingKeys: String, CodingKey {
		case user, text
		case createdAt = "created_at"
	}
}
