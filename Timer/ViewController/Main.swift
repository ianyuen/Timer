//
//  Main.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit
import AVFoundation

class Main: ViewController {
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

	var session = Session()
	var workout = Workout()

	var angle: CGFloat = 0
	var angleTotal: CGFloat = 0
	var angleRatio: CGFloat = 0

	var coolDown = false
	var counting = false

	var counter:CGFloat = 0
	var endSecond: CGFloat = 0
	var totalSecond:CGFloat = 0

	var leftRest = 0
	var leftRound = 0
	var totalRest = 0
	var totalRound = 0

	var player: AVAudioPlayer?

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)

		var index = Database.instance.ReadInt("workoutIndex")
		var workouts = Database.instance.ReadWorkouts("workouts")
		if workouts.count == 0 {
			index = 0
			workouts.append(Workout())
			Database.instance.SaveWorkouts("workouts", object: workouts)
		}

		workout = workouts[index]
		endSecond = CGFloat(workout.warmUp) * 10
		totalRest = workout.rounds - 1
		totalRound = workout.rounds
		totalSecond = GetTotalTime() * 10
		angleRatio = endSecond / 60

		let selector = #selector(update)
		Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: selector, userInfo: nil, repeats: true);
		initView()

		if Database.instance.HaveData("defaultWorkout") == false {
			var workouts = [Workout]()
			workouts.append(Workout())
			Database.instance.SaveWorkouts("defaultWorkout", object: workouts)
		}
	#if DEBUG
		PrintFontNames()
	#endif
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
			case "mainButton":
				DrawNewButton(object)
			case "background":
				DrawBackground(object)
			case "roundButton":
				objectManager.AddButton(roundButton, parent: view, object: object, target: self)
				roundButton.endTime.text = ConvertToClock(workout.warmUp * 10)
			default: break
			}
		}
	}

	func ResetTimer() {
		counting = false
		
		angle = 0
		leftRest = 0
		leftRound = 0
		
		totalRound = workout.rounds
		totalSecond = GetTotalTime() * 10
		endSecond = CGFloat(workout.warmUp) * 10
		
		counter = 0
		angleTotal = 0
		angleRatio = endSecond / 60
		
		round.text = "ROUND   " + NumberToString(leftRound) + "/" + NumberToString(totalRound)
		endClock.text = ConvertToClock(Int(totalSecond))
		
		roundButton.initView()
		roundButton.endTime.text = ConvertToClock(Int(endSecond))
	}

	func DrawLabel(_ object: ScreenObject) {
		switch object.name {
		case "round":
			object.text = "ROUND   " + NumberToString(leftRound) + "/" + NumberToString(totalRound)
			round.textAlignment = NSTextAlignment.center
			objectManager.AddLabel(round, parent: view, object: object)
		case "endTime":
			objectManager.AddLabel(endTime, parent: view, object: object)
		case "endClock":
			object.text = ConvertToClock(Int(totalSecond))
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

	func AddNewButton(_ button: MainButton, object: ScreenObject) {
		button.SetIcon(object.icon)
		button.SetTitle(object.text)
		button.SetWidth(object.width)
		button.SetHeight(object.height)
		objectManager.AddButton(button, parent: view, object: object, target: self)
	}

	func DrawNewButton(_ object: ScreenObject) {
		switch object.name {
		case "startButton":
			AddNewButton(startButton, object: object)
		case "resetButton":
			let touched = #selector(MainButton.Touched(_:))
			resetButton.addTarget(resetButton, action: touched, for: .touchDown)
			let released = #selector(MainButton.Released(_:))
			resetButton.addTarget(resetButton, action: released, for: .touchUpInside)
			AddNewButton(resetButton, object: object)
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

	func update() {
		if (counting) {
			let image = UIImage(named: "stop")
			startButton.SetIcon(image!)
			startButton.SetTitle("PAUSE")
			startButton.ChangeBackColor(0xA6E1FD)

			if counter >= angleTotal {
				roundButton.DrawCircle(angle)
				angle = angle + CGFloat.pi / 30
				angleTotal = angleTotal + angleRatio
			}
			counter = counter + 1
			endSecond = endSecond - 1
			if endSecond == 5 {
				PlaySound(workout.sound)
			}
			if endSecond < 0 {
				angle = 0
				if leftRound < totalRound {
					if leftRest == leftRound {
						endSecond = CGFloat(workout.roundTime) * 10

						counter = 0
						angleTotal = 0
						angleRatio = endSecond / 60

						leftRound = leftRound + 1

						let leftText = NumberToString(leftRound)
						let totalText = NumberToString(totalRound)
						round.text = "ROUND   " + leftText + "/" + totalText
						roundButton.SetAnim("round")
					} else {
						endSecond = CGFloat(workout.rest) * 10

						counter = 0
						angleTotal = 0
						angleRatio = endSecond / 60

						leftRest = leftRest + 1
						round.text = "REST TIME"
						roundButton.SetAnim("rest")
					}
				} else {
					if coolDown {
						counting = false
						let totalText = NumberToString(totalRound)
						round.text = "ROUND   " + totalText + "/" + totalText

						session.epoch = Double(floor(NSDate().timeIntervalSince1970))
						session.rounds = workout.rounds
						session.restTime = workout.rest
						session.roundTime = workout.roundTime
						session.roundsName = workout.roundsName
						session.warmUpTime = workout.warmUp
						session.coolDownTime = workout.coolDown
						session.totalRounds = workout.rounds
						session.totalTrainingTime = Int(GetTotalTime())
						session.training = workout.name
						var sessions = Database.instance.ReadSessions("sessions")
						sessions.append(session)
						Database.instance.SaveSessions("sessions", object: sessions)

						AskLaunchCalis()
					} else {
						endSecond = CGFloat(workout.coolDown) * 10

						counter = 0
						angleTotal = 0
						angleRatio = endSecond / 60

						coolDown = true
						round.text = "COOL DOWN"
						roundButton.SetAnim("cool")
					}
				}
				roundButton.initView()
			} else {
				totalSecond = totalSecond - 1
			}
			endClock.text = ConvertToClock(Int(totalSecond))
			roundButton.endTime.text = ConvertToClock(Int(endSecond))
		} else {
			let image = UIImage(named: "start")
			startButton.SetIcon(image!)
			startButton.SetTitle("START")
			startButton.ChangeBackColor(0x008FDC)
		}
		startButton.SizeToFit()
		resetButton.SetTitle("RESET")
	}

	func btnResetClicked(_ sender: UIButton!) {
		/*
		counting = false

		angle = 0
		leftRest = 0
		leftRound = 0

		totalRound = workout.rounds
		totalSecond = GetTotalTime() * 10
		endSecond = CGFloat(workout.warmUp) * 10

		counter = 0
		angleTotal = 0
		angleRatio = endSecond / 60

		round.text = "ROUND   " + NumberToString(leftRound) + "/" + NumberToString(totalRound)
		endClock.text = ConvertToClock(Int(totalSecond))
		
		roundButton.initView()
		roundButton.endTime.text = ConvertToClock(Int(endSecond))
		*/
	}

	func btnStartClicked(_ sender: UIButton!) {
		Start()
	}
	
	func btnRoundClicked(_ sender: UIButton!) {
		Start()
	}
	
	func btnHistoryClicked(_ sender: UIButton!) {
		self.performSegue(withIdentifier: "showHistory", sender: self)
		ResetTimer()
	}
	
	func btnSettingsClicked(_ sender: UIButton!) {
		self.performSegue(withIdentifier: "showSettings", sender: self)
		ResetTimer()
	}

	func GetTotalTime() -> CGFloat {
		var total: CGFloat = 0
		let rounds = workout.rounds
		total = total + CGFloat((workout.rest * (rounds - 1)))
		total = total + CGFloat(workout.warmUp)
		total = total + CGFloat(workout.coolDown)
		total = total + CGFloat(workout.roundTime * rounds)
		return total
	}

	func AskLaunchCalis() {
		let message = "Are you want open Calisthenics?"
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		let noAction = UIAlertAction(title: "No", style: .cancel) { _ in }
		let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
			let ourApplication = UIApplication.shared
			let URLEncodedText = "test"
			let ourPath = "workouts://" + URLEncodedText
			let ourURL = NSURL(string: ourPath)
			if ourApplication.canOpenURL(ourURL as! URL) {
				if #available(iOS 10.0, *) {
					ourApplication.open(ourURL as! URL, options: [:], completionHandler: nil)
				} else {
					ourApplication.openURL(ourURL as! URL)
				}
			}
		}
		alert.addAction(yesAction)
		alert.addAction(noAction)
		present(alert, animated: true, completion: nil)
	}

	func PlaySound(_ sound: String) {
		let url = Bundle.main.url(forResource: sound, withExtension: "mp3")!
		do {
			player = try AVAudioPlayer(contentsOf: url)
			guard let player = player else { return }
			
			player.prepareToPlay()
			player.play()
		} catch let error {
			print(error.localizedDescription)
		}
	}

	func Start() {
		counting = !counting
		if counting {
			if leftRound == 0 {
				round.text = "WARM UP"
				angleTotal = angleTotal + angleRatio
			}
		}
	}

	func PrintFontNames() {
		let fontFamilyNames = UIFont.familyNames
		for familyName in fontFamilyNames {
			print("Font Family Name = [\(familyName)]")
			let names = UIFont.fontNames(forFamilyName: familyName)
			print("Font Names = [\(names)]")
		}
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
		let convert = Int(value / 10)
		let minute = convert / 60
		let second = convert % 60

		var result = ""
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
}
