//
//  StartButton.swift
//  Timer
//
//  Created by ian on 11/23/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
	let background1 = UIImageView()
	let background2 = UIImageView()
	let background3 = UIImageView()
	
	var width: CGFloat = 0
	var height: CGFloat = 0
	var parent: UIViewController? = nil
	
	init(_ controller: UIViewController) {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		parent = controller

		let objectManager = ObjectManager(view: self, controller: parent!)
		objectManager.Parse("RoundButton")
		objectManager.DrawObject(background1, type: "image", name: "background1")
		objectManager.DrawObject(background2, type: "image", name: "background2")
		objectManager.DrawObject(background3, type: "image", name: "background3")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func initView() {
	}
}
