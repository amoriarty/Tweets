//
//  MainController+TableView.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 16/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

extension MainController {
	func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TweetCell.self, forCellReuseIdentifier: cellid)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tweets?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! TweetCell
		guard let tweet = tweets?[indexPath.item] else { return cell }
		cell.tweet = tweet
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return searchBar
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard let tweet = tweets?[indexPath.item] else { return 0 }
		let size = CGSize(width: tableView.frame.width - 75, height: 1000)
		let estimatedFrame = tweet.attributed.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
		return estimatedFrame.height + 20
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50
	}
}
