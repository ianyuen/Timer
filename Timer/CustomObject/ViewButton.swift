//
//  ViewButton.swift
//  Timer
//
//  Created by ian on 12/15/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ViewButton: Button {
	let objectManager = ObjectManager()

	let label = UILabel()
	let image = UIImageView()

	private var index: Int = 0

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("ViewButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "image":
				objectManager.AddImage(image, parent: self, object: object)
			case "label":
				objectManager.AddLabel(label, parent: self, object: object)
			default: break
			}
		}
	}

	func Index(_ value: Int) { index = value }
	func Index() -> Int { return index }
}
