//
//  NewButton.swift
//  Timer
//
//  Created by ian on 12/2/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class NewButton: Button {
	let objectManager = ObjectManager()

	private var text = ""
	private var width: CGFloat = 0
	private var height: CGFloat = 0

	let title = UILabel()
	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("NewButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				object.text = text
				objectManager.AddLabel(title, parent: self, object: object)
			case "background":
				object.width = width
				object.height = height
				objectManager.AddBackground(background, parent: self, object: object)
			default: break
			}
		}
		layer.masksToBounds = true
		layer.cornerRadius = 8
	}

	func SetController(_ viewController: UIViewController) {
		objectManager.controller = viewController
	}

	func SetText(_ value: String) {
		text = value
	}

	func SetWidth(_ value: CGFloat) {
		width = value
	}

	func SetHeight(_ value: CGFloat) {
		height = value
	}
}
