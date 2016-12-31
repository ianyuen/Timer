//
//  MainButton.swift
//  Timer
//
//  Created by ian on 11/23/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class MainButton: Button {
	let objectManager = ObjectManager()

	private var icon = UIImageView()
	private let title = UILabel()
	private let background = UIImageView()

	var parent = UIViewController()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("MainButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "image":
				DrawImage(object)
			case "label":
				object.text = title.text!
				objectManager.AddLabel(title, parent: self, object: object)
			default: break
			}
		}
	}

	func SetIcon(_ value: UIImage) {
		icon.image = value
	}

	func SetTitle(_ value: String) {
		title.text = value
	}

	func SizeToFit() {
		title.sizeToFit()
	}

	func DrawImage(_ object: ScreenObject) {
		switch object.name {
		case "icon":
			object.icon = icon.image!
			objectManager.AddImage(icon, view: self, object: object)
		case "background":
			objectManager.AddImage(background, view: self, object: object)
		default: break
		}
	}
}
