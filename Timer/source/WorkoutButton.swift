//
//  WorkoutButton.swift
//  Timer
//
//  Created by ian on 12/9/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class WorkoutButton: Button {
	let objectManager = ObjectManager()
	
	var name = ""
	var lines: CGFloat = 0
	var height: CGFloat = 0

	let textView = UITextView()
	let background = UILabel()
	
	override func initView() {
		objectManager.parent = self
		objectManager.Parse("WorkoutButton")
		for object in objectManager.GetObjects() {
			if height > 0 {
				object.height = height
			}
			switch object.type {
			case "textView":
				object.text = name
				objectManager.AddTextView(textView, view: self, object: object)
				lines = GetLinesNumber(textView)
			case "background":
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}

		let color = Color()
		backgroundColor = color.UIColorFromHex(0xf9aa43)
	}

	func GetLinesNumber(_ textView: UITextView) -> CGFloat {
		let font: UIFont = textView.font!
		let style = NSMutableParagraphStyle()
		style.lineBreakMode = NSLineBreakMode.byWordWrapping
		let size = textView.text.size(attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: style])
		return (size.width / frame.width) + 1
	}
}
