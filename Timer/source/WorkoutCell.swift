//
//  WorkoutCell.swift
//  Timer
//
//  Created by ian on 12/2/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class WorkoutCell: ScrollView {
	let objectManager = ObjectManager()

	let space = ScreenSize.instance.GetItemHeight(10)
	let workoutName = ["Profile Name", "Insane Fat Blasting BootCamp", "Barbell Tabata Workout"]

	let insane = WorkoutButton()
	let barbell = WorkoutButton()
	let profile = WorkoutButton()

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("WorkoutCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "workoutButton":
				AddButton(object)
			default: break
			}
		}

		let color = Color()
		backgroundColor = color.UIColorFromHex(0xf9aa43)
	}

	func AddButton(_ object: ScreenObject) {
		switch object.name {
		case "insane":
			insane.name = workoutName[1]
			objectManager.AddButton(insane, view: self, object: object)
			if insane.lines > 1 {
				object.height = 250
				insane.height = 250
				objectManager.AddButton(insane, view: self, object: object)
			}
		case "barbell":
			barbell.name = workoutName[2]
			objectManager.AddButton(barbell, view: self, object: object)
			barbell.frame.origin.y = insane.frame.origin.y + insane.frame.height + space
		case "profile":
			profile.name = workoutName[0]
			objectManager.AddButton(profile, view: self, object: object)
		default: break
		}
	}
}
