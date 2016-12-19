//
//  Main.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Main: UIViewController {
	var counting = false
	let round = UILabel()
	let endTime = UILabel()
	let endClock = UILabel()
	let background = UILabel()
	let resetButton = MainButton()
	let startButton = MainButton()
	let roundButton = RoundButton()
	let screenTitle = UILabel()
	let objectManager = ObjectManager()
	let historyButton = Button()
	let settingsButton = Button()
	let titleBackground = UILabel()

	var angle: CGFloat = 0.0
	var endSecond = 60
	var roundNumber = 15
	var totalSecond = 900

	override var shouldAutorotate: Bool {
		return false
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return UIInterfaceOrientationMask.portrait
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)

		let selector = #selector(update)
		Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: selector, userInfo: nil, repeats: true);
		initView()
		//PrintFontNames()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
	}

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Main")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				DrawLabel(object)
			case "button":
				DrawButton(object)
			case "background":
				DrawBackground(object)
			case "mainButton":
				DrawMainButton(object)
			case "roundButton":
				objectManager.AddButton(roundButton, view: view, object: object)
			default: break
			}
		}
	}

	func DrawLabel(_ object: ScreenObject) {
		switch object.name {
		case "round":
			objectManager.AddLabel(round, view: view, object: object)
		case "endTime":
			objectManager.AddLabel(endTime, view: view, object: object)
		case "endClock":
			objectManager.AddLabel(endClock, view: view, object: object)
		case "screenTitle":
			objectManager.AddLabel(screenTitle, view: view, object: object)
		default: break
		}
	}

	func DrawButton(_ object: ScreenObject) {
		switch object.name {
		case "historyButton":
			historyButton.setImage(object.icon, for: UIControlState.normal)
			objectManager.AddButton(historyButton, view: view, object: object)
		case "settingsButton":
			settingsButton.setImage(object.icon, for: UIControlState.normal)
			objectManager.AddButton(settingsButton, view: view, object: object)
		default: break
		}
	}

	func DrawMainButton(_ object: ScreenObject) {
		switch object.name {
		case "startButton":
			startButton.SetIcon(object.icon)
			startButton.SetTitle(object.text)
			objectManager.AddButton(startButton, view: view, object: object)
		case "resetButton":
			resetButton.SetIcon(object.icon)
			resetButton.SetTitle(object.text)
			objectManager.AddButton(resetButton, view: view, object: object)
		default: break
		}
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "background":
			objectManager.AddBackground(background, view: view, object: object)
		case "titleBackground":
			objectManager.AddBackground(titleBackground, view: view, object: object)
		default: break
		}
	}

	func btnResetClicked(_ sender:UIButton!) {
		angle = 0
		counting = false
		endSecond = 60
		roundButton.endTime.text = ConvertToClock(endSecond)
		totalSecond = 900
		endClock.text = ConvertToClock(totalSecond)
		roundNumber = 15
		round.text = "ROUND   " + String(roundNumber) + "/15"
		roundButton.initView()
	}

	func btnStartClicked(_ sender:UIButton!) {
		counting = !counting
	}

	func btnRoundClicked(_ sender:UIButton!) {
		counting = !counting
	}

	func btnHistoryClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showHistory", sender: self)
	}

	func btnSettingsClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showSettings", sender: self)
	}

	func ConvertToClock(_ value: Int) -> String{
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
				roundNumber = roundNumber - 1
				if roundNumber < 10 {
					round.text = "ROUND   0" + String(roundNumber) + "/15"
				} else {
					round.text = "ROUND   " + String(roundNumber) + "/15"
				}
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

	func PrintFontNames() {
		let fontFamilyNames = UIFont.familyNames
		for familyName in fontFamilyNames {
			print("------------------------------")
			print("Font Family Name = [\(familyName)]")
			let names = UIFont.fontNames(forFamilyName: familyName)
			print("Font Names = [\(names)]")
		}
	}
}
