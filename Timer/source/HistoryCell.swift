//
//  HistoryCell.swift
//  Timer
//
//  Created by ian on 12/13/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class HistoryCell: TableViewCell {
	var parent = UIView()
	let objectManager = ObjectManager()

	let date = HistoryDetail()
	let time = HistoryDetail()
	let training = HistoryDetail()
	let background = UILabel()
	let historyButton = HistoryButton()

	private var dateContent = ""
	private var timeContent = ""
	private var trainingContent = ""

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				objectManager.AddBackground(background, parent: self, object: object)
			case "historyDetail":
				AddHistoryDetail(object)
			case "historyButton":
				objectManager.AddView(historyButton, parent: self, object: object)
			default: break
			}
		}
	}

	func AddHistoryDetail(_ object: ScreenObject) {
		switch object.name {
		case "date":
			date.SetTitle(object.text)
			date.SetContent(dateContent)
			objectManager.AddView(date, parent: self, object: object)
		case "time":
			time.SetTitle(object.text)
			time.SetContent(timeContent)
			objectManager.AddView(time, parent: self, object: object)
		case "training":
			training.SetTitle(object.text)
			training.SetContent(trainingContent)
			objectManager.AddView(training, parent: self, object: object)
		default: break
		}
	}

	func SetDateContent(_ content: String) {
		dateContent = content
	}

	func SetTimeContent(_ content: String) {
		timeContent = content
	}

	func SetTrainingContent(_ content: String) {
		trainingContent = content
	}
}
