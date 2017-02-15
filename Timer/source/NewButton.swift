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
	private var backColor: UInt32 = 0
	private var touchColor: UInt32 = 0

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
				backColor = object.backColor
				touchColor = object.touchColor
				objectManager.AddBackground(background, parent: self, object: object)
			default: break
			}
		}
		addTarget(self, action: #selector(Touched(_:)), for: .touchDown)
		addTarget(self, action: #selector(Released(_:)), for: .touchUpInside)
	}

	func Touched(_ sender: Button!) {
		ChangeBackColor(touchColor)
	}

	func Released(_ sender: Button!) {
		ChangeBackColor(backColor)
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

	func SetBackColor(_ value: UInt32) {
		backColor = value
	}

	func SetTouchColor(_ value: UInt32) {
		touchColor = value
	}

	func ChangeBackColor(_ value: UInt32) {
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
