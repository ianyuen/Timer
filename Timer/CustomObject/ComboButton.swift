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
	private var childrens = [String]()
	private var fontSize: CGFloat = 0
	private var textColor: UInt32 = 0
	private var expandHeight: CGFloat = 0

	let icon = UIImageView()
	let label = UILabel()
	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("ComboButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				object.text = childrens[0]
				objectManager.AddLabel(label, view: self, object: object)
			case "image":
				objectManager.AddImage(icon, view: self, object: object)
			case "background":
				DrawBackground(object: object)
			default: break
			}
		}
		layer.masksToBounds = true
		layer.cornerRadius = 8
	}

	func DrawBackground(object: ScreenObject) {
		switch object.name {
		case "background":
			object.width = width
			object.height = height
			objectManager.AddBackground(background, view: self, object: object)
		default: break
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

	func SetChildrens(_ values: [String]) {
		for value in values {
			childrens.append(value)
		}
	}

	func GetChildrens() -> [String] {
		return childrens
	}
}
