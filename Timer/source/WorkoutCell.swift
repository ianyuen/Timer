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

		let color = Color()
		backgroundColor = color.UIColorFromHex(0xf9aa43)

		workouts = Database.instance.ReadWorkouts("workouts")
		if workouts.count == 0 {
			workouts.append(Workout())
			Database.instance.SaveWorkouts("workouts", object: workouts)
		}

		let object = ScreenObject()
		object.round = true
		object.width = 1142
		object.height = 128
		object.clicked = #selector(btnWorkoutClicked(_:))
		object.xPosition = 50
		object.textColor = 0x000000

		var index = 0
		for workout in workouts {
			let button = WorkoutButton()
			object.text = workout.name
			button.Index(index)
			button.SetText(object.text)
			button.SetWidth(object.width)
			button.SetHeight(object.height)
			button.title.textColor = color.UIColorFromHex(0xffffff)
			objectManager.AddButton(button, parent: self, object: object)
			index = index + 1
			object.yPosition = object.yPosition + object.height + 10
		}

		let height: CGFloat = CGFloat((workouts.count * 128) + ((workouts.count - 1) * 10))
		let contentHeight = ScreenSize.instance.GetItemHeight(height)
		contentSize = CGSize(width: frame.width, height: contentHeight)
	}

	func SetCurrentWorkout(_ data: Int) {
		Database.instance.SaveInt("workoutIndex", data: data)
	}

	func btnWorkoutClicked(_ sender: WorkoutButton!) {
		Application.instance.WorkoutIndex(sender.Index())
		SetCurrentWorkout(sender.Index())
	}
}
