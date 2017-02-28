//
//  DetailsCell.swift
//  Timer
//
//  Created by ian on 12/4/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class DetailsCell: ScrollView {
	var savePosY: CGFloat = 0
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

	let line = UILabel()
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
	var exercises = [Exercise]()

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		DismissKeyboard()
		GetTotalTime()
		let roundNumber = Int(roundsNumber.textField.text!)
		if roundNumber != workout.rounds {
			workout.rounds = roundNumber!

			for childrent in exercises {
				childrent.removeFromSuperview()
			}
			ExercisesGenerate()

			NewPosButton(saveButton)
			NewPosButton(deleteButton)

			let contentHeight: CGFloat = fitContentHeight()
			contentSize = CGSize(width: frame.width, height: contentHeight)
		}
	}

	override func initView() {
		if Application.instance.GetWorkoutTask() == Application.WorkoutTask.edit {
			let index = Application.instance.WorkoutIndex()
			let workouts = Database.instance.ReadWorkouts("workouts")
			workout = workouts[index]
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
				AddBackground(object)
			case "roundSecondsGroup":
				AddRoundSecondsGroup(object)
			default: break
			}
		}

		if workout.routine == false {
			exercise.isHidden = true
		} else {
			ExercisesGenerate()
			NewPosButton(saveButton)
			NewPosButton(deleteButton)
		}

		let contentHeight: CGFloat = fitContentHeight()
		contentSize = CGSize(width: frame.width, height: contentHeight)

		redTime.textBox.textField.text = String(workout.rest)
		roundTime.textBox.textField.text = String(workout.roundTime)
		warmUpTime.textBox.textField.text = String(workout.warmUp)
		coolDownTime.textBox.textField.text = String(workout.coolDown)
		
		profileText.textField.text = workout.name
		roundsNumber.textField.text = String(workout.rounds)

		GetTotalTime()
	}

	func AddLabel(_ object: ScreenObject) {
		switch object.name {
		case "soundText":
			objectManager.AddLabel(soundText, parent: self, object: object)
		case "vibrateText":
			objectManager.AddLabel(vibrateText, parent: self, object: object)
		case "routineText":
			objectManager.AddLabel(routineText, parent: self, object: object)
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

	func AddBackground(_ object: ScreenObject) {
		switch object.name {
		case "line":
			objectManager.AddBackground(line, parent: self, object: object)
		case "background":
			objectManager.AddBackground(background, parent: self, object: object)
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
			savePosY = saveButton.frame.origin.y
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
		workout.roundsName = ExercisesGetName()

		workout.rest = Int(redTime.textBox.textField.text!)!
		workout.warmUp = Int(warmUpTime.textBox.textField.text!)!
		workout.coolDown = Int(coolDownTime.textBox.textField.text!)!
		workout.roundTime = Int(roundTime.textBox.textField.text!)!

		workout.sound = sound.GetTitle()
		workout.vibrate = vibrate.GetTitle() == "Yes" ? true : false
		workout.routine = routine.GetTitle() == "Yes" ? true : false
		//workout.motivation = motivation.GetTitle() == "Yes" ? true : false

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

		let alarmAction = UIAlertAction(title: "Alarm", style: .default) { _ in
			self.sound.SetTitle("Alarm")
			self.workout.sound = "Alarm"
		}
		let beepAction = UIAlertAction(title: "Beep", style: .default) { _ in
			self.sound.SetTitle("Beep")
			self.workout.sound = "Beep"
		}
		let bellAction = UIAlertAction(title: "Bell", style: .default) { _ in
			self.sound.SetTitle("Bell")
			self.workout.sound = "Bell"
		}
		let clickAction = UIAlertAction(title: "Click", style: .default) { _ in
			self.sound.SetTitle("Click")
			self.workout.sound = "Click"
		}
		let tickingAction = UIAlertAction(title: "Ticking", style: .default) { _ in
			self.sound.SetTitle("Ticking")
			self.workout.sound = "Ticking"
		}

		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(alarmAction)
		alert.addAction(beepAction)
		alert.addAction(bellAction)
		alert.addAction(clickAction)
		alert.addAction(tickingAction)
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
			self.HideExercises()
		}
		let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
			self.routine.SetTitle("Yes")
			self.workout.routine = true
			self.ShowExercises()
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

	func NewPosButton(_ button: Button) {
		var y = savePosY
		if workout.routine {
			let exercisesHeight = ExercisesGetHeight()
			y = exercisesHeight + button.frame.height
		}

		let x = button.frame.origin.x
		let width = button.frame.width
		let height = button.frame.height

		button.frame = CGRect(x: x, y: y, width: width, height: height)
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

	func ShowExercises() {
		exercise.isHidden = false
		ExercisesGenerate()
		NewPosButton(saveButton)
		NewPosButton(deleteButton)

		let contentHeight = fitContentHeight()
		contentSize = CGSize(width: frame.width, height: contentHeight)

	}

	func HideExercises() {
		exercise.isHidden = true
		for childrent in exercises {
			childrent.removeFromSuperview()
		}
		NewPosButton(saveButton)
		NewPosButton(deleteButton)

		let contentHeight = fitContentHeight()
		contentSize = CGSize(width: frame.width, height: contentHeight)
	}

	func ExercisesGetName() -> [String] {
		var result = [String]()
		for childrent in exercises {
			result.append(childrent.GetContent())
		}
		return result
	}

	func ExercisesGetHeight() -> CGFloat {
		var contentHeight: CGFloat = 0
		for childrent in exercises {
			let viewHeight = childrent.frame.origin.y + childrent.frame.height
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		return contentHeight
	}

	func ExercisesGenerate() {
		var posY: CGFloat = 2038 + 145 + 30 + 30

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
