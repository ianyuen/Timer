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

	var parent = UIViewController()

	func initView(_ controller: UIViewController) {
		objectManager.parent = self
		objectManager.controller = controller
		objectManager.Parse("MainButton")
		objectManager.DrawObject(background, type: "image", name: "background")
		objectManager.DrawObject(icon, type: "image", name: "icon", image: image)
		objectManager.DrawObject(title, type: "label", name: "title", angle: 0, spec: title.text!)
	}
}
