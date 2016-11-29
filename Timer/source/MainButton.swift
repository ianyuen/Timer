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
	let title = UILabel()
	var image = ""
	let background = UIImageView()
	let objectManager = ObjectManager()

	var width: CGFloat = 0
	var height: CGFloat = 0
	var parent: UIViewController? = nil

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func initView(_ controller: UIViewController) {
		objectManager.parentView = self
		objectManager.parentController = controller
		objectManager.Parse("MainButton")
		objectManager.DrawObject(background, type: "image", name: "background")
		objectManager.DrawObject(icon, type: "image", name: "icon", image: image)
		objectManager.DrawObject(title, type: "label", name: "title", angle: 0, spec: title.text!)
	}
}
