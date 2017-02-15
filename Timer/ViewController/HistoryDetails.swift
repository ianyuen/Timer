//
//  HistoryDetails.swift
//  Timer
//
//  Created by Thanh Long on 1/5/17.
//  Copyright © 2017 ian. All rights reserved.
//

import UIKit

class HistoryDetails: ViewController {
	let objectManager = ObjectManager()

	let backButton = BackButton()
	let titleText = UILabel()
	let deleteButton = NewButton()
	let content = HistoryDetailsScroll()
	let background = UILabel()


	override func viewDidLoad() {
		super.viewDidLoad()

		objectManager.parent = view
		objectManager.Parse("HistoryDetails")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				objectManager.AddLabel(titleText, parent: view, object: object)
			case "newButton":
				deleteButton.SetText(object.text)
				deleteButton.SetWidth(object.width)
				deleteButton.SetHeight(object.height)
				objectManager.AddButton(deleteButton, parent: view, object: object, target: self)
			case "backButton":
				DrawButton(object)
			case "scrollView":
				content.controller = self
				objectManager.AddScrollView(content, view: view, object: object)
			case "background":
				DrawBackground(object)
			default: break
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func DrawButton(_ object: ScreenObject) {
		switch object.name {
		case "backButton":
			objectManager.AddButton(backButton, parent: view, object: object, target: self)
		default: break
		}
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "background":
			objectManager.AddBackground(background, parent: view, object: object)
		default: break
		}
	}

	func btnBackClicked(_ sender: Button!) {
		PerformSegue("showHistory")
	}

	func btnDeleteClicked(_ sender: Button!) {
		let message = "Delete?"
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

		let noAction = UIAlertAction(title: "No", style: .cancel) { _ in }
		let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
			var sessions = Database.instance.ReadSessions("sessions")
			sessions.remove(at: Application.instance.SessionIndex())
			Database.instance.SaveSessions("sessions", object: sessions)
			self.PerformSegue("showHistory")
		}
		alert.addAction(noAction)
		alert.addAction(yesAction)
		present(alert, animated: true, completion: nil)
	}
}
