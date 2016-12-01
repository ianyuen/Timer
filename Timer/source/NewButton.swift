//
//  NewButton.swift
//  Timer
//
//  Created by ian on 12/2/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class NewButton: UIButton {
	let title = UILabel()
	let background = UIImageView()
	let objectManager = ObjectManager()

	func initView() {
		objectManager.Parse("NewButton")
		objectManager.DrawObject(background, type: "image", name: "background")
		objectManager.DrawObject(title, type: "label", name: "title", angle: 0, spec: title.text!)
	}

	func SetController(_ viewController: UIViewController) {
		objectManager.parent = self
		objectManager.controller = viewController
	}
}
