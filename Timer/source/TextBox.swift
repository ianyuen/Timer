//
//  TextBox.swift
//  Timer
//
//  Created by ian on 12/5/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class TextBox: UIView {
	let objectManager = ObjectManager()

	private var text = ""
	private var image = UIImage()
	private var width: CGFloat = 0
	private var height: CGFloat = 0
	private var fontName = ""
	private var fontSize: CGFloat = 0

	private var backColor: UInt32 = 0
	private var textColor: UInt32 = 0

	let textField = UITextField()
	let background = UILabel()

	func initView() {
		objectManager.parent = self
		objectManager.Parse("TextBox")
		for object in objectManager.GetObjects() {
			object.width = width
			object.height = height
			switch object.type {
			case "textField":
				object.text = text
				object.font = fontName
				object.size = fontSize
				objectManager.AddTextField(textField, view: self, object: object)
			case "background":
				object.backColor = backColor
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}
	}

	func SetText(_ value: String) {
		text = value
	}

	func SetFont(_ name: String, size: CGFloat) {
		fontName = name
		fontSize = size
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

	func SetTextColor(_ value: UInt32) {
		textColor = value
	}

	func SetBackground(_ value: UIImage) {
		image = value
	}
}