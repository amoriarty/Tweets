//
//  TweetCell.swift
//  Tweets
//
//  Created by Alexandre LEGENT on 16/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
	
	
	var tweet: Tweet? {
		didSet {
			guard let tweet = tweet else { return }
			textView.attributedText = tweet.attributed
		}
	}
	
	let picture: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = .black
		imageView.layer.cornerRadius = 5
		return imageView
	}()
	
	let textView: UITextView = {
		let view = UITextView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isEditable = false
		view.isSelectable = false
		view.isScrollEnabled = false
		view.textContainerInset = UIEdgeInsets(top: -4, left: -4, bottom: -4, right: -4)
		return view
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(picture)
		addSubview(textView)
		setupLayouts()
	}
	
	private func setupLayouts() {
		_ = picture.constraint(.top, to: self, constant: 10)
		_ = picture.constraint(.leading, to: self, constant: 10)
		_ = picture.constraint(dimension: .height, constant: 50)
		_ = picture.constraint(dimension: .width, constant: 50)
		
		_ = textView.fill(.verticaly, self, constant: 10)
		_ = textView.constraint(.leading, to: picture, .trailing, constant: 5)
		_ = textView.constraint(.trailing, to: self, constant: 10)
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
