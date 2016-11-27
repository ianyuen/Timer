//
//  MainButton.swift
//  Timer
//
//  Created by ian on 11/23/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class MainButton: UIButton {
	let icon = UIImageView()
	var image = ""
	let title = UILabel()
	let background = UIImageView()

	var width: CGFloat = 0
	var height: CGFloat = 0
	var parent: UIViewController? = nil

	init(_ controller: UIViewController) {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		parent = controller
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func initView() {
		let objectManager = ObjectManager(view: self, controller: parent!)
		objectManager.Parse("MainButton")
		objectManager.DrawObject(background, type: "image", name: "background")
		objectManager.DrawObject(icon, type: "image", name: "icon", image: image)
		objectManager.DrawObject(title, type: "label", name: "title", angle: 0, spec: title.text!)
	}
}
