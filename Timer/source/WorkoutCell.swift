//
//  WorkoutCell.swift
//  Timer
//
//  Created by ian on 12/2/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class WorkoutCell: ScrollView {
	var controller = UIViewController()
	let objectManager = ObjectManager()

	let space = ScreenSize.instance.GetItemHeight(10)
	var workouts = [Workout]()
	let workoutName = [String]()

	let workoutButtons = [WorkoutButton]()

	override func initView() {
		objectManager.parent = self

		let contentHeight = fitContentHeight()
		contentSize = CGSize(width: frame.width, height: contentHeight)

		let color = Color()
		backgroundColor = color.UIColorFromHex(0xf9aa43)

		workouts = Database.instance.ReadWorkouts("workouts")
		if workouts.count == 0 {
			workouts.append(Workout(coder: NSCoder())!)
			Database.instance.SaveWorkouts("workouts", object: workouts)
		}

		let object = ScreenObject()
		object.round = true
		object.width = 1142
		object.height = 128
		object.clicked = #selector(btnWorkoutClicked(_:))
		object.xPosition = 50

		for workout in workouts {
			let button = WorkoutButton()
			object.text = workout.name
			button.SetText(object.text)
			button.SetWidth(object.width)
			button.SetHeight(object.height)
			objectManager.AddButton(button, parent: self, object: object)
			object.yPosition = object.height + 10
		}
		SetCurrentWorkout(workouts[0].name)
	}

	func SetCurrentWorkout(_ data: String) {
		Database.instance.SaveString("currentWorkout", data: data)
	}

	func btnWorkoutClicked(_ sender: WorkoutButton!) {
		Application.instance.SetCurrentWorkout(sender.title.text!)
	}
}
