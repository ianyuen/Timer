//
//  ExercisesGroup.swift
//  Timer
//
//  Created by ian on 2/27/17.
//  Copyright © 2017 ian. All rights reserved.
//

import UIKit

class ExercisesGroup: View {
	let objectManager = ObjectManager()
	var exercises = [Exercise]()

	override func initView() {
		objectManager.parent = self

		var posY: CGFloat = 0
		let index = Application.instance.WorkoutIndex()
		let workouts = Database.instance.ReadWorkouts("workouts")
		let workout = workouts[index]

		exercises = [Exercise]()
		for i in 1 ... workout.rounds {
			let name = "Round " + String(i)
			if workout.roundsName.count < i {
				workout.roundsName.append(name)
			}
			let exercise = Exercise()
			exercise.SetTitle(name)
			exercise.SetContent(workout.roundsName[i - 1])
			exercises.append(exercise)

			let object = ScreenObject()
			object.yPosition = posY
			object.height = 254
			objectManager.AddView(exercise, parent: self, object: object)
			posY = posY + 256
		}
	}

	func GetRoundsName() -> [String] {
		var result = [String]()
		for exercise in exercises {
			result.append(exercise.GetContent())
		}
		return result
	}

	func GetContentHeight() -> CGFloat {
		var contentHeight: CGFloat = 0
		for view in subviews {
			let viewHeight = view.frame.origin.y + view.frame.height
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		return contentHeight
	}

	func RemoveChildrent() {
		for view in subviews {
			view.removeFromSuperview()
		}
		let x = frame.origin.x
		let y = frame.origin.y
		let width = frame.width
		let height: CGFloat = 0
		frame = CGRect(x: x, y: y, width: width, height: height)
	}
}
