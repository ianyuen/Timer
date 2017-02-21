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

	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryDetailsScroll")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				objectManager.AddBackground(background, parent: self, object: object)
			case "historyDetail":
				FindHistoryDetail(object)
			default: break
			}
		}
	}

	func AddHistoryDetail(_ historyDetail: HistoryDetail, object: ScreenObject, content: String) {
		historyDetail.SetTitle(object.text)
		historyDetail.SetContent(content)
		objectManager.AddView(historyDetail, parent: self, object: object)
	}

	func FindHistoryDetail(_ object: ScreenObject) {
		let sessions = Database.instance.ReadSessions("sessions")
		let session = sessions[Application.instance.SessionIndex()]

		var content = ""
		var historyDetail = HistoryDetail()
		switch object.name {
		case "date":
			let nsDate = NSDate(timeIntervalSince1970: session.epoch)
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MMM/dd/YYYY"
			content = dateFormatter.string(from: nsDate as Date)
			historyDetail = date
		case "time":
			let nsDate = NSDate(timeIntervalSince1970: session.epoch)
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "hh:mm a"
			content = dateFormatter.string(from: nsDate as Date)
			historyDetail = time
		case "warmUpTime":
			content = String(session.warmUpTime) + "'"
			historyDetail = warmUpTime
		case "restTime":
			content = String(session.restTime) + "'"
			historyDetail = restTime
		case "coolDownTime":
			content = String(session.coolDownTime) + "'"
			historyDetail = coolDownTime
		case "roundTime":
			content = String(session.roundTime) + "'"
			historyDetail = roundTime
		case "totalRounds":
			content = String(session.totalRounds)
			historyDetail = totalRounds
		case "rounds":
			content = String(session.rounds) + "/" + String(session.totalRounds)
			historyDetail = rounds
		case "training":
			content = session.training
			historyDetail = training
		case "totalTrainingTime":
			let minute = session.totalTrainingTime / 60
			let second = session.totalTrainingTime % 60
			content = String(minute) + "'" + String(second) + "'"
			historyDetail = totalTrainingTime
		default: break
		}

		AddHistoryDetail(historyDetail, object: object, content: content)
	}
}
