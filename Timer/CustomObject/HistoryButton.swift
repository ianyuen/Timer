//
//  HistoryButton.swift
//  Timer
//
//  Created by ian on 12/15/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class HistoryButton: View {
	let objectManager = ObjectManager()

	let deleteButton = Button()
	let background = UILabel()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "button":
				AddButton(object)
			case "background":
				objectManager.AddBackground(background, view: self, object: object)
			default: break
			}
		}
	}

	func AddButton(_ object: ScreenObject) {
		switch object.name {
		case "deleteButton":
			objectManager.AddButton(deleteButton, view: self, object: object)
		default: break
		}
	}
}
