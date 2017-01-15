//
//  HistoryDetailsScroll.swift
//  Timer
//
//  Created by Thanh Long on 1/15/17.
//  Copyright © 2017 ian. All rights reserved.
//

import UIKit

class HistoryDetailsScroll: ScrollView {
	var controller = ViewController()
	let objectManager = ObjectManager()

	let date = HistoryDetail()
	let time = HistoryDetail()
	let warmUpTime = HistoryDetail()
	let restTime = HistoryDetail()
	let coolDownTime = HistoryDetail()
	let roundTime = HistoryDetail()
	let totalRounds = HistoryDetail()
	let rounds = HistoryDetail()
	let training = HistoryDetail()
	let totalTrainingTime = HistoryDetail()

	let line1 = SingleLine()
	let line2 = SingleLine()
	let line3 = SingleLine()
	let line4 = SingleLine()
	let line5 = SingleLine()
	let line6 = SingleLine()
	let line7 = SingleLine()
	let line8 = SingleLine()
	let line9 = SingleLine()

	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryDetailsScroll")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "line":
				AddLine(object)
			case "background":
				objectManager.AddBackground(background, parent: self, object: object)
			case "historyDetail":
				FindHistoryDetail(object)
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
		case "line4":
			objectManager.AddLine(line4, parent: self, object: object)
		case "line5":
			objectManager.AddLine(line5, parent: self, object: object)
		case "line6":
			objectManager.AddLine(line6, parent: self, object: object)
		case "line7":
			objectManager.AddLine(line7, parent: self, object: object)
		case "line8":
			objectManager.AddLine(line8, parent: self, object: object)
		case "line9":
			objectManager.AddLine(line9, parent: self, object: object)
		default: break
		}
	}

	func AddHistoryDetail(_ historyDetail: HistoryDetail, object: ScreenObject) {
		historyDetail.SetTitle(object.text)
		//historyDetail.SetContent(dateContent)
		objectManager.AddView(historyDetail, parent: self, object: object)
	}

	func FindHistoryDetail(_ object: ScreenObject) {
		var historyDetail = HistoryDetail()
		switch object.name {
		case "date":
			historyDetail = date
		case "time":
			historyDetail = time
		case "warmUpTime":
			historyDetail = warmUpTime
		case "restTime":
			historyDetail = restTime
		case "coolDownTime":
			historyDetail = coolDownTime
		case "roundTime":
			historyDetail = roundTime
		case "totalRounds":
			historyDetail = totalRounds
		case "rounds":
			historyDetail = rounds
		case "training":
			historyDetail = training
		case "totalRounds":
			historyDetail = totalRounds
		case "totalTrainingTime":
			historyDetail = totalTrainingTime
		default: break
		}

		AddHistoryDetail(historyDetail, object: object)
	}
}
