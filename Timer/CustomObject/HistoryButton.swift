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

	let background = UILabel()
	let viewButton = ViewButton()
	let deleteButton = Button()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "button":
				objectManager.AddButton(deleteButton, parent: self, object: object)
			case "viewButton":
				objectManager.AddButton(viewButton, parent: self, object: object, target: History())
			case "background":
				objectManager.AddBackground(background, parent: self, object: object)
			default: break
			}
		}
		layer.masksToBounds = true
		layer.cornerRadius = 8
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}
}
