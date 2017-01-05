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

	let background = UILabel()

	override func viewDidLoad() {
		super.viewDidLoad()

		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Main")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				DrawBackground(object)
			default: break
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "background":
			objectManager.AddBackground(background, parent: view, object: object)
		default: break
		}
	}
}
