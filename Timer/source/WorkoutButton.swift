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
	let textView = UITextView()
	let background = UILabel()
	
	override func initView() {
		objectManager.parent = self
		objectManager.Parse("WorkoutButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "textView":
				object.text = name
				objectManager.AddTextView(textView, view: self, object: object)
			case "background":
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}

		let color = Color()
		backgroundColor = color.UIColorFromHex(0xf9aa43)
	}
}
