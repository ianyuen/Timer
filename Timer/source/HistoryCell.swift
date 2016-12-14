//
//  HistoryCell.swift
//  Timer
//
//  Created by ian on 12/13/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class HistoryCell: View {
	let objectManager = ObjectManager()

	let date = UILabel()
	let time = UILabel()
	let line1 = SingleLine()
	let line2 = SingleLine()
	let line3 = SingleLine()
	let training = UILabel()
	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "line":
				AddLine(object)
			case "label":
				AddLabel(object)
			case "background":
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}
	}

	func AddLine(_ object: ScreenObject) {
		switch object.name {
		case "line1":
			objectManager.AddLine(line1, parent: self, object: object)
		case "line2":
			objectManager.AddLine(line2, parent: self, object: object)
		case "line3":
			objectManager.AddLine(line3, parent: self, object: object)
		default: break
		}
	}

	func AddLabel(_ object: ScreenObject) {
		switch object.name {
		case "date":
			objectManager.AddLabel(date, view: self, object: object)
		case "time":
			objectManager.AddLabel(time, view: self, object: object)
		case "training":
			objectManager.AddLabel(training, view: self, object: object)
		default: break
		}
	}
}
