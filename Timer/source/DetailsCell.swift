//
//  DetailsCell.swift
//  Timer
//
//  Created by ian on 12/4/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class DetailsCell: ScrollView {
	var controller = ViewController()
	let objectManager = ObjectManager()

	let totalText = TextBox()
	let profileText = TextBox()

	let roundsTitle = UILabel()
	let roundsNumber = TextBox()
	let trainingTime = UILabel()

	let background = UILabel()

	let redTime = RoundSecondsGroup()
	let roundTime = RoundSecondsGroup()
	let warmUpTime = RoundSecondsGroup()
	let coolDownTime = RoundSecondsGroup()

	let sound = ComboButton()
	let soundText = UILabel()

	let vibrate = ComboButton()
	let vibrateText = UILabel()

	let routine = ComboButton()
	let routineText = UILabel()

	let motivation = ComboButton()
	let motivationText = UILabel()

	let exercise = UILabel()

	let round1Text = TextBox()
	let round1Title = UILabel()

	let round2Text = TextBox()
	let round2Title = UILabel()

	let saveButton = NewButton()
	let deleteButton = NewButton()

	var timeRest = 0
	var timeRound = 0
	var timeTotal = 0
	var workout = Workout()

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		DismissKeyboard()
		GetTotalTime()
	}

	override func initView() {
		if Application.instance.GetWorkoutTask() == Application.WorkoutTask.edit {
			let workoutIndex = Application.instance.WorkoutIndex()
			let workouts = Database.instance.ReadWorkouts("workouts")
			workout = workouts[workoutIndex]
		}

		objectManager.parent = self
		objectManager.Parse("DetailsCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				AddLabel(object)
			case "button":
				AddButton(object)
			case "textBox":
				AddTextBox(object)
			case "comboBox":
				AddComboBox(object)
			case "newButton":
				AddButton(object)
			case "background":
				objectManager.AddBackground(background, parent: self, object: object)
			case "line":
				AddLine(object)
			case "roundSecondsGroup":
				AddRoundSecondsGroup(object)
			default: break
			}
		}

		var contentHeight: CGFloat = 0
		for view in subviews {
			let viewHeight = view.frame.origin.y + view.frame.height
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		contentSize = CGSize(width: frame.width, height: contentHeight)

		redTime.textBox.textField.text = String(workout.rest)
		roundTime.textBox.textField.text = String(workout.roundTime)
		warmUpTime.textBox.textField.text = String(workout.warmUp)
		coolDownTime.textBox.textField.text = String(workout.coolDown)
		
		profileText.textField.text = workout.name
		roundsNumber.textField.text = String(workout.rounds)

		GetTotalTime()
	}

	func AddLine(_ object: ScreenObject) {
		switch object.name {
		default: break
		}
	}

	func AddLabel(_ object: ScreenObject) {
		switch object.name {
		case "soundText":
			objectManager.AddLabel(soundText, parent: self, object: object)
		case "vibrateText":
			objectManager.AddLabel(vibrateText, parent: self, object: object)
		case "routineText":
			objectManager.AddLabel(routineText, parent: self, object: object)
		case "motivationText":
			objectManager.AddLabel(motivationText, parent: self, object: object)
		case "roundsTitle":
			objectManager.AddLabel(roundsTitle, parent: self, object: object)
		case "round1Title":
			objectManager.AddLabel(round1Title, parent: self, object: object)
		case "round2Title":
			objectManager.AddLabel(round2Title, parent: self, object: object)
		case "exercise":
			objectManager.AddLabel(exercise, parent: self, object: object)
		case "trainingTime":
			objectManager.AddLabel(trainingTime, parent: self, object: object)

		default: break
		}
	}

	func AddTextBox(_ object: ScreenObject) {
		switch object.name {
		case "totalText":
			totalText.textField.isUserInteractionEnabled = false
			totalText.SetTextColor(object.textColor)
			objectManager.AddTextBox(totalText, view: self, object: object)
		case "round1Text":
			objectManager.AddTextBox(round1Text, view: self, object: object)
		case "round2Text":
			objectManager.AddTextBox(round2Text, view: self, object: object)
		case "profileText":
			object.text = profileText.textField.text!
			profileText.SetTextColor(object.textColor)
			objectManager.AddTextBox(profileText, view: self, object: object)
		case "roundsNumber":
			object.text = roundsNumber.textField.text!
			roundsNumber.textField.keyboardType = UIKeyboardType.numberPad
			objectManager.AddTextBox(roundsNumber, view: self, object: object)
		default: break
		}
	}

	func AddComboBox(_ object: ScreenObject) {
		switch object.name {
		case "sound":
			object.title = workout.sound
			objectManager.AddComboButton(sound, parent: self, object: object)
		case "vibrate":
			object.title = workout.vibrate ? "Yes" : "No"
			objectManager.AddComboButton(vibrate, parent: self, object: object)
		case "routine":
			object.title = workout.routine ? "Yes" : "No"
			objectManager.AddComboButton(routine, parent: self, object: object)
		case "motivation":
			object.title = workout.motivation ? "Yes" : "No"
			objectManager.AddComboButton(motivation, parent: self, object: object)
		default: break
		}
	}

	func AddRoundSecondsGroup(_ object: ScreenObject) {
		switch object.name {
		case "redTime":
			redTime.textBox.textField.keyboardType = UIKeyboardType.numberPad
			objectManager.AddRoundSecondsGroup(redTime, parent: self, object: object)
		case "roundTime":
			roundTime.textBox.textField.keyboardType = UIKeyboardType.numberPad
			objectManager.AddRoundSecondsGroup(roundTime, parent: self, object: object)
		case "warmUpTime":
			warmUpTime.textBox.textField.keyboardType = UIKeyboardType.numberPad
			objectManager.AddRoundSecondsGroup(warmUpTime, parent: self, object: object)
		case "coolDownTime":
			coolDownTime.textBox.textField.keyboardType = UIKeyboardType.numberPad
			objectManager.AddRoundSecondsGroup(coolDownTime, parent: self, object: object)
		default: break
		}
	}

	func AddButton(_ object: ScreenObject) {
		switch object.name {
		case "saveButton":
			saveButton.SetText(object.text)
			saveButton.SetWidth(object.width)
			saveButton.SetHeight(object.height)
			objectManager.AddButton(saveButton, parent: self, object: object, target: self)
		case "deleteButton":
			deleteButton.SetText(object.text)
			deleteButton.SetWidth(object.width)
			deleteButton.SetHeight(object.height)
			objectManager.AddButton(deleteButton, parent: self, object: object, target: self)
		default: break
		}
	}

	func btnSaveClicked(_ sender: Button) {
		workout.name = profileText.textField.text!
		workout.rounds = Int(roundsNumber.textField.text!)!

		workout.rest = Int(redTime.textBox.textField.text!)!
		workout.warmUp = Int(warmUpTime.textBox.textField.text!)!
		workout.coolDown = Int(coolDownTime.textBox.textField.text!)!
		workout.roundTime = Int(roundTime.textBox.textField.text!)!

		workout.sound = sound.GetTitle()
		workout.vibrate = vibrate.GetTitle() == "Yes" ? true : false
		workout.routine = routine.GetTitle() == "Yes" ? true : false
		workout.motivation = motivation.GetTitle() == "Yes" ? true : false

		var workouts = Database.instance.ReadWorkouts("workouts")
		switch Application.instance.GetWorkoutTask() {
		case Application.WorkoutTask.new:
			var canAdd = true
			for temp in workouts {
				if temp.name == profileText.textField.text {
					canAdd = false
					break
				}
			}
			if canAdd {
				workouts.append(workout)
				Database.instance.SaveWorkouts("workouts", object: workouts)
				controller.PerformSegue("showSettings")
			} else {
				let message = "Can't add exist profile"
				let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
				let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
				alert.addAction(okAction)
				controller.present(alert, animated: true, completion: nil)
			}
		case Application.WorkoutTask.edit:
			workouts[Application.instance.WorkoutIndex()] = workout
			Database.instance.SaveWorkouts("workouts", object: workouts)
			controller.PerformSegue("showSettings")
		}
	}

	func btnDeleteClicked(_ sender: Button) {
		var message = "Delete?"
		if Application.instance.GetWorkoutTask() == Application.WorkoutTask.new {
			message = "You can't delete when create profile"
		}
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

		switch Application.instance.GetWorkoutTask() {
		case Application.WorkoutTask.new:
			let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
			alert.addAction(okAction)
		case Application.WorkoutTask.edit:
			let noAction = UIAlertAction(title: "No", style: .cancel) { _ in }
			let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
				self.DeleteWorkout()
			}

			alert.addAction(noAction)
			alert.addAction(yesAction)
		}
		controller.present(alert, animated: true, completion: nil)
	}

	func btnSoundClicked(_ sender:UIButton!) {
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
		
		let noAction = UIAlertAction(title: "No", style: .default) { _ in
			self.sound.SetTitle("No")
			self.workout.sound = "No"
		}
		let gymAction = UIAlertAction(title: "Gym", style: .default) { _ in
			self.sound.SetTitle("Gym")
			self.workout.sound = "Gym"
		}
		let humanAction = UIAlertAction(title: "Human", style: .default) { _ in
			self.sound.SetTitle("Human")
			self.workout.sound = "Human"
		}
		let boxingAction = UIAlertAction(title: "Boxing", style: .default) { _ in
			self.sound.SetTitle("Boxing")
			self.workout.sound = "Boxing"
		}
		let digitalAction = UIAlertAction(title: "Digital", style: .default) { _ in
			self.sound.SetTitle("Digital")
			self.workout.sound = "Digital"
		}

		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(digitalAction)
		alert.addAction(boxingAction)
		alert.addAction(humanAction)
		alert.addAction(gymAction)
		alert.addAction(noAction)
		alert.addAction(cancelAction)
		controller.present(alert, animated: true, completion: nil)
	}
	
	func btnVibrateClicked(_ sender:UIButton!) {
		let noAction = UIAlertAction(title: "No", style: .default) { _ in
			self.vibrate.SetTitle("No")
			self.workout.vibrate = false
		}
		let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
			self.vibrate.SetTitle("Yes")
			self.workout.vibrate = true
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }

		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(yesAction)
		alert.addAction(noAction)
		alert.addAction(cancelAction)
		controller.present(alert, animated: true, completion: nil)
	}
	
	func btnRoutineClicked(_ sender:UIButton!) {
		let noAction = UIAlertAction(title: "No", style: .default) { _ in
			self.routine.SetTitle("No")
			self.workout.routine = false
		}
		let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
			self.routine.SetTitle("Yes")
			self.workout.routine = true
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
		
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(yesAction)
		alert.addAction(noAction)
		alert.addAction(cancelAction)
		controller.present(alert, animated: true, completion: nil)
	}
	
	func btnMotivationClicked(_ sender:UIButton!) {
		let noAction = UIAlertAction(title: "No", style: .default) { _ in
			self.motivation.SetTitle("No")
			self.workout.motivation = false
		}
		let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
			self.motivation.SetTitle("Yes")
			self.workout.motivation = true
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
		
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(yesAction)
		alert.addAction(noAction)
		alert.addAction(cancelAction)
		controller.present(alert, animated: true, completion: nil)
	}

	func IntToString(_ value: Int) -> String {
		var result = ""
		if value < 10 {
			result = result + "0"
		}
		result = result + String(value)
		return result
	}

	func GetTotalTime() {
		let rest = StringToInt(redTime.textBox.textField.text!)
		let warm = StringToInt(warmUpTime.textBox.textField.text!)
		let cool = StringToInt(coolDownTime.textBox.textField.text!)
		let round = StringToInt(roundTime.textBox.textField.text!)
		let rounds = StringToInt(roundsNumber.textField.text!)
		let total = warm + cool + (rest * (rounds - 1)) + (round * rounds)
		totalText.textField.text = SecondToString(total)
	}

	func CanDelete() -> Bool {
		let workouts = Database.instance.ReadWorkouts("workouts")
		if workouts.count == 1 {
			return false
		}
		return true
	}

	func DeleteWorkout() {
		if CanDelete() {
			var index = Application.instance.WorkoutIndex()
			var workouts = Database.instance.ReadWorkouts("workouts")
			workouts.remove(at: index)
			Database.instance.SaveWorkouts("workouts", object: workouts)

			index = index - 1
			if index < 0 {
				index = 0
			}
			Application.instance.WorkoutIndex(index)
			Database.instance.SaveInt("workoutIndex", data: index)
			self.controller.PerformSegue("showSettings")
		} else {
			let message = "You can not delete this workout"
			let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
			let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in }
			alert.addAction(okAction)
			controller.present(alert, animated: true, completion: nil)
		}
	}

	func StringToInt(_ value: String) -> Int {
		return Int(value)!
	}

	func SecondToString(_ value: Int) -> String {
		let minute = value / 60
		let second = value % 60

		var result = ""
		if minute > 0 {
			result = result + IntToString(minute) + " Minutes and "
		}
		result = result + IntToString(second) + " Seconds"
		return result
	}
}
