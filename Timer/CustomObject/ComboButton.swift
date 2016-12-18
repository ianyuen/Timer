//
//  ComboBox.swift
//  Timer
//
//  Created by ian on 12/6/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ComboButton: Button {
	let objectManager = ObjectManager()

	private var text = ""
	private var width: CGFloat = 0
	private var height: CGFloat = 0
	private var fontName = ""
	private var fontSize: CGFloat = 0
	private var textColor: UInt32 = 0

	let icon = UIImageView()
	let textBox = UILabel()
	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("ComboButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "image":
				objectManager.AddImage(icon, view: self, object: object)
			case "background":
				object.width = width
				object.height = height
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}
	}

	func SetText(_ string: String, color: UInt32) {
		text = string
		textColor = color
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
}
