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

	private var width: CGFloat = 0
	private var height: CGFloat = 0
	private var backColor: UInt32 = 0
	private var touchColor: UInt32 = 0

	private var icon = UIImageView()
	private let title = UILabel()
	private let background = UILabel()

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
			case "background":
				object.width = width
				object.height = height
				objectManager.AddBackground(background, parent: self, object: object)
			default: break
			}
		}
	}

	func Touched(_ sender: Button!) {
		ChangeBackColor(0xA6E1FD)
	}
	
	func Released(_ sender: Button!) {
		ChangeBackColor(0x008FDC)
	}

	func SetIcon(_ value: UIImage) {
		icon.image = value
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

	func SizeToFit() {
		title.sizeToFit()
	}

	func DrawImage(_ object: ScreenObject) {
		switch object.name {
		case "icon":
			object.icon = icon.image!
			objectManager.AddImage(icon, parent: self, object: object)
		default: break
		}
	}

	func ChangeBackColor(_ value: UInt32) {
		let color = Color()
		background.backgroundColor = color.UIColorFromHex(value)
	}
}
