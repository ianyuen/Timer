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

	let date = HistoryDetail()
	let time = HistoryDetail()
	let line1 = SingleLine()
	let line2 = SingleLine()
	let line3 = SingleLine()
	let training = HistoryDetail()
	let background = UILabel()
	let historyButton = HistoryButton()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "line":
				AddLine(object)
			case "background":
				objectManager.AddBackground(background, view: self, object: object)
			case "historyDetail":
				AddHistoryDetail(object)
			case "historyButton":
				objectManager.AddView(historyButton, parent: self, object: object)
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

	func AddHistoryDetail(_ object: ScreenObject) {
		switch object.name {
		case "date":
			date.SetTitle(object.text)
			objectManager.AddView(date, parent: self, object: object)
		case "time":
			time.SetTitle(object.text)
			objectManager.AddView(time, parent: self, object: object)
		case "training":
			training.SetTitle(object.text)
			objectManager.AddView(training, parent: self, object: object)
		default: break
		}
	}
}
