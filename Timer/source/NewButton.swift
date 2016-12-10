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

	let title = UILabel()
	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("NewButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				object.text = text
				objectManager.AddLabel(title, view: self, object: object)
			case "background":
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}
	}

	func SetController(_ viewController: UIViewController) {
		objectManager.controller = viewController
	}

	func SetText(_ value: String) {
		text = value
	}
}
