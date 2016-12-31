//
//  ComboExpand.swift
//  Timer
//
//  Created by ian on 12/28/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ComboExpand: View {
	private let objectManager = ObjectManager()

	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("ComboExpand")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				objectManager.AddBackground(background, parent: self, object: object)
			default: break
			}
		}
		//layer.masksToBounds = true
		//layer.cornerRadius = 8
	}

	func DrawChildren(_ childrens: [String]) {
		let object = ScreenObject()
		object.size = 15
		object.font = "LiberationSans"
		object.clicked = #selector(ComboExpand.clicked(_:))
		object.textColor = 0x373639
		object.xPosition = 500
		object.width = 400
		object.height = 128

		var index: Int = 0
		for children in childrens {
			object.title = children
			object.yPosition = CGFloat(870 + (128 * index))
			index = index + 1

			let button = Button()
			objectManager.AddButton(button, view: self, object: object)
			button.addTarget(self, action: object.clicked!, for: .touchUpInside)
		}
	}

	func DrawLine(_ numLine: Int) {
		let line = SingleLine()
		let object = ScreenObject()
		object.xPosition = 0
		object.xPosition = 1564
		object.width = 400
		object.height = 5
		objectManager.AddLine(line, parent: self, object: object)
	}

	func clicked(_ sender: Button) {
		print("click")
	}
}
