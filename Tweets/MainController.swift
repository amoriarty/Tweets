//
//  MainController.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, APITwitterDelegate {
	private let cellid = "tweeeeets"
	var service: TweetService?
	var tweets: [Tweet]?
	
	let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Tweets"
		view.backgroundColor = .white
		setupTableView()
		DataService.shared.getToken { token in
			guard let token = token else { return }
			self.service = TweetService(token: token, delegate: self)
			self.service?.search("ecole 42")
		}
	}
	
	private func setupTableView() {
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TweetCell.self, forCellReuseIdentifier: cellid)
		_ = tableView.constraint(.top, to: view)
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
	
	func handle(tweets: [Tweet]) {
		self.tweets = tweets
		tableView.reloadData()
	}
	
	func handle(error: Error) {
		print(error)
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
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard let tweet = tweets?[indexPath.item] else { return 0 }
		let size = CGSize(width: tableView.frame.width - 75, height: 1000)
		let estimatedFrame = tweet.attributed.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
		return estimatedFrame.height + 20
	}
}

