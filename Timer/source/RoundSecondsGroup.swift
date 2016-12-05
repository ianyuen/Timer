//
//  RoundSecondGroup.swift
//  Timer
//
//  Created by ian on 12/5/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class RoundSecondsGroup: UIView {
	var controller = UIViewController()
	let objectManager = ObjectManager()

	private var text = ""
	private var image = UIImage()

	let icon = UIImageView()
	let title = UILabel()
	let textBox = TextBox()
	let seconds = UILabel()

	func initView() {
		objectManager.parent = self
		objectManager.controller = controller
		objectManager.Parse("RoundSecondGroup")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				DrawLabel(object)
			case "image":
				object.icon = image
				objectManager.AddImage(icon, view: self, object: object)
			case "textBox":
				objectManager.AddTextBox(textBox, view: self, object: object)
			default: break
			}
		}
	}

	func SetTitle(_ value: String) {
		text = value
	}

	func SetImage(_ value: UIImage) {
		image = value
	}

	func SetController(_ viewController: UIViewController) {
		controller = viewController
	}

	func DrawLabel(_ object: ScreenObject) {
		switch object.name {
		case "title":
			object.text = text
			objectManager.AddLabel(title, view: self, object: object)
		case "seconds":
			objectManager.AddLabel(seconds, view: self, object: object)
		default: break
		}
	}
}
