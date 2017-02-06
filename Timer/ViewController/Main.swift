//
//  Main.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Main: ViewController {
	var counting = false
	let round = UILabel()
	let endTime = UILabel()
	let endClock = UILabel()
	let background = UILabel()
	let resetButton = MainButton()
	let startButton = MainButton()
	let roundButton = RoundButton()
	let screenTitle = UITextField()
	let objectManager = ObjectManager()
	let historyButton = Button()
	let settingsButton = Button()
	let titleBackground = UILabel()

	var angle: CGFloat = 0.0
	var workout = Workout()
	var endSecond = 60
	var leftRound = 0
	var totalRound = 0
	var totalSecond = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)

		var index = Database.instance.ReadWorkoutIndex("workoutIndex")
		var workouts = Database.instance.ReadWorkouts("workouts")
		if workouts.count == 0 {
			index = 0
			workouts.append(Workout())
			Database.instance.SaveWorkouts("workouts", object: workouts)
		}

		workout = workouts[index]
		leftRound = 0
		totalRound = workout.rounds
		totalSecond = GetTotalTime()

		let selector = #selector(update)
		Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: selector, userInfo: nil, repeats: true);
		initView()

		if Database.instance.HaveData("defaultWorkout") == false {
			var workouts = [Workout]()
			workouts.append(Workout())
			Database.instance.SaveWorkouts("defaultWorkout", object: workouts)
		}

		//PrintFontNames()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func initView() {
		objectManager.parent = view
		objectManager.Parse("Main")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "textField":
				object.text = workout.name
				objectManager.AddTextField(screenTitle, parent: view, object: object)
			case "label":
				DrawLabel(object)
			case "button":
				DrawButton(object)
			case "background":
				DrawBackground(object)
			case "mainButton":
				DrawMainButton(object)
			case "roundButton":
				objectManager.AddButton(roundButton, parent: view, object: object, target: self)
			default: break
			}
		}
	}

	func DrawLabel(_ object: ScreenObject) {
		switch object.name {
		case "round":
			object.text = "ROUND   " + NumberToString(leftRound) + "/" + NumberToString(totalRound)
			objectManager.AddLabel(round, parent: view, object: object)
		case "endTime":
			objectManager.AddLabel(endTime, parent: view, object: object)
		case "endClock":
			object.text = ConvertToClock(totalSecond)
			objectManager.AddLabel(endClock, parent: view, object: object)
		default: break
		}
	}

	func DrawButton(_ object: ScreenObject) {
		switch object.name {
		case "historyButton":
			historyButton.setImage(object.icon, for: UIControlState.normal)
			objectManager.AddButton(historyButton, parent: view, object: object, target: self)
		case "settingsButton":
			settingsButton.setImage(object.icon, for: UIControlState.normal)
			objectManager.AddButton(settingsButton, parent: view, object: object, target: self)
		default: break
		}
	}

	func DrawMainButton(_ object: ScreenObject) {
		switch object.name {
		case "startButton":
			startButton.SetIcon(object.icon)
			startButton.SetTitle(object.text)
			objectManager.AddButton(startButton, parent: view, object: object, target: self)
		case "resetButton":
			resetButton.SetIcon(object.icon)
			resetButton.SetTitle(object.text)
			objectManager.AddButton(resetButton, parent: view, object: object, target: self)
		default: break
		}
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "background":
			objectManager.AddBackground(background, parent: view, object: object)
		case "titleBackground":
			objectManager.AddBackground(titleBackground, parent: view, object: object)
		default: break
		}
	}

	func btnResetClicked(_ sender: UIButton!) {
		angle = 0
		counting = false
		endSecond = 60

		let index = Database.instance.ReadWorkoutIndex("workoutIndex")
		let workouts = Database.instance.ReadWorkouts("workouts")
		totalRound = workouts[index].rounds
		totalSecond = GetTotalTime()

		roundButton.endTime.text = ConvertToClock(endSecond)
		endClock.text = ConvertToClock(totalSecond)

		round.text = "ROUND   " + NumberToString(totalRound) + "/" + NumberToString(totalRound)
		roundButton.initView()
	}

	func update() {
		if (counting) {
			let image = UIImage(named: "stop")
			startButton.SetIcon(image!)
			startButton.SetTitle("PAUSE")

			roundButton.DrawCircle(angle)
			angle = angle + CGFloat.pi / 30

			endSecond = endSecond - 1
			if endSecond < 0 {
				angle = 0
				roundButton.initView()
				endSecond = 60
				leftRound = leftRound + 1
				round.text = "ROUND   " + NumberToString(leftRound) + "/" + NumberToString(totalRound)
			}

			roundButton.endTime.text = ConvertToClock(endSecond)

			totalSecond = totalSecond - 1
			endClock.text = ConvertToClock(totalSecond)
		} else {
			let image = UIImage(named: "start")
			startButton.SetIcon(image!)
			startButton.SetTitle("START")
		}
		startButton.SizeToFit()
		resetButton.SetTitle("RESET")
	}

	func btnStartClicked(_ sender: UIButton!) {
		counting = !counting
	}
	
	func btnRoundClicked(_ sender: UIButton!) {
		counting = !counting
	}
	
	func btnHistoryClicked(_ sender: UIButton!) {
		self.performSegue(withIdentifier: "showHistory", sender: self)
	}
	
	func btnSettingsClicked(_ sender: UIButton!) {
		self.performSegue(withIdentifier: "showSettings", sender: self)
	}

	func NumberToString(_ value: Int) -> String {
		var result = ""
		if value < 10 {
			result = result + "0"
		}
		result = result + String(value)
		return result
	}

	func ConvertToClock(_ value: Int) -> String {
		var result = ""
		let minute = value / 60
		let second = value % 60
		if minute < 10 {
			result = result + "0"
		}
		result = result + String(minute) + ":"
		if second < 10 {
			result = result + "0"
		}
		result = result + String(second)
		return result
	}

	func GetTotalTime() -> Int {
		let rest = workout.rest
		let warmUp = workout.warmUp
		let rounds = workout.rounds
		let coolDown = workout.coolDown
		let roundTime = workout.roundTime
		return warmUp + coolDown + (rest * (rounds - 1)) + (roundTime * rounds)
	}

	func PrintFontNames() {
		let fontFamilyNames = UIFont.familyNames
		for familyName in fontFamilyNames {
			print("Font Family Name = [\(familyName)]")
			let names = UIFont.fontNames(forFamilyName: familyName)
			print("Font Names = [\(names)]")
		}
	}
}
