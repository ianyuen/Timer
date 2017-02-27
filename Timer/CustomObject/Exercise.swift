//
//  Exercise.swift
//  Timer
//
//  Created by ian on 2/27/17.
//  Copyright © 2017 ian. All rights reserved.
//

import UIKit

class Exercise: View {
	private var titleText = ""
	private var textBoxText = ""
	private let objectManager = ObjectManager()

	private let title = UILabel()
	private let textBox = TextBox()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("Exercise")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				object.text = titleText
				objectManager.AddLabel(title, parent: self, object: object)
			case "textBox":
				object.text = textBoxText
				objectManager.AddTextBox(textBox, view: self, object: object)
			default: break
			}
		}
		isUserInteractionEnabled = true
	}

	func SetTitle(_ title: String) {
		titleText = title
	}

	func SetContent(_ content: String) {
		textBoxText = content
	}

	func GetContent() -> String {
		return textBox.textField.text!
	}
}
