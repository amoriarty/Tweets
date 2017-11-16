//
//  MainController.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,  APITwitterDelegate {
	let cellid = "tweeeeets"
	let headerid = "search"
	var service: TweetService?
	var tweets: [Tweet]?
	
	let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	let searchBar: UISearchBar = {
		let bar = UISearchBar()
		bar.text = "ecole 42"
		return bar
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Tweets"
		view.backgroundColor = .white
		view.addSubview(tableView)
		searchBar.delegate = self
		setupTableView()
		setupLayouts()
		setupService()
	}
	
	private func setupService() {
		DataService.shared.getToken { token in
			guard let token = token else { return }
			self.service = TweetService(token: token, delegate: self)
			self.service?.search("ecole 42")
		}
	}
	
	private func setupLayouts() {
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
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		guard let text = searchBar.text, text != "" else { return }
		service?.search(text)
	}
}

