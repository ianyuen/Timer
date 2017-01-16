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

	var textField = UITextField()
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
				if textColor != 0 {
					object.textColor = textColor
				}
				objectManager.AddTextField(textField, view: self, object: object)
				let selector = #selector(textFieldDidChange(_:))
				textField.addTarget(self, action: selector, for: .editingChanged)
			case "background":
				object.backColor = backColor
				objectManager.AddBackground(background, parent: self, object: object)
			default: break
			}
		}
		layer.masksToBounds = true
		if frame.width < 50 {
			layer.cornerRadius = 4
		} else if frame.width < 100 {
			layer.cornerRadius = 6
		} else if frame.width < 150 {
			layer.cornerRadius = 8
		} else {
			layer.cornerRadius = 8
		}
	}

	func SetText(_ value: String) {
		text = value
	}

	func GetText() -> String {
		return text
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

	func textFieldDidChange(_ sender: UITextField) {
		text = sender.text!
	}
}
