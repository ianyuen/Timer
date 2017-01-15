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
		self.performSegue(withIdentifier: "showHistory", sender: self)
	}
}
