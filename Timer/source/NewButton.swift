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

	private var icon = UIImageView()
	let title = UILabel()
	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("NewButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "image":
				DrawImage(object)
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
	}

	func SetText(_ value: String) {
		text = value
	}

	func SetTitle(_ value: String) {
		title.text = value
	}

	func SetWidth(_ value: CGFloat) {
		width = value
	}

	func SetHeight(_ value: CGFloat) {
		height = value
	}

	func SetBackgroundColor(_ value: UInt32) {
		let color = Color()
		background.backgroundColor = color.UIColorFromHex(value)
	}

	func DrawImage(_ object: ScreenObject) {
		switch object.name {
		case "icon":
			objectManager.AddImage(icon, parent: self, object: object)
		default: break
		}
	}

	func SizeToFit() {
		title.sizeToFit()
	}
}
