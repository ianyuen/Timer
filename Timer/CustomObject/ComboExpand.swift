//
//  ComboExpand.swift
//  Timer
//
//  Created by ian on 12/28/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ComboExpand: View {
	let objectManager = ObjectManager()

	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("ComboExpand")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}
		//layer.masksToBounds = true
		//layer.cornerRadius = 8
	}

	func DrawChildren(_ childrens: [String]) {
		//var textView = UILabel[childrens.count]()
		let object = ScreenObject()
		object.size = 15
		object.font = "LiberationSans"
		object.textColor = 0x373639
		object.xPosition = 500

		var index: Int = 0
		for children in childrens {
			object.text = children
			object.yPosition = CGFloat(870 + (128 * index))
			index = index + 1

			let label = UILabel()
			label.isUserInteractionEnabled = true
			objectManager.AddLabel(label, view: self, object: object)
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
}
