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
	let historyButton = UIButton()
	let settingsButton = UIButton()
	let titleBackground = UILabel()

	var angle: CGFloat = 0.0
	var endSecond = 60
	var roundNumber = 15
	var totalSecond = 900

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)
		_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true);
		initView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	func initView() {
		objectManager.parentView = view
		objectManager.parentController = self
		objectManager.Parse("Main")
		objectManager.DrawObject(background, type: "background", name: "background")
		objectManager.DrawObject(round, type: "label", name: "round")
		objectManager.DrawObject(screenTitle, type: "label", name: "title")
		objectManager.DrawObject(historyButton, type: "button", name: "historyButton")
		objectManager.DrawObject(settingsButton, type: "button", name: "settingsButton")

		objectManager.DrawObject(titleBackground, type: "background", name: "titleBackground")
		objectManager.DrawObject(endTime, type: "label", name: "endTime")
		objectManager.DrawObject(endClock, type: "label", name: "endClock")

		objectManager.DrawObject(roundButton, type: "roundButton", name: "roundButton")

		objectManager.DrawObject(startButton, type: "mainButton", name: "startButton")
		objectManager.DrawObject(resetButton, type: "mainButton", name: "resetButton")
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
		roundButton.initView(self)
	}

	func btnStartClicked(_ sender:UIButton!) {
		counting = !counting
	}

	func btnRoundClicked(_ sender:UIButton!) {
		counting = !counting
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
			startButton.icon.image = image
			startButton.title.text = "PAUSE"

			roundButton.DrawCircle(angle)
			angle = angle + CGFloat.pi / 30

			endSecond = endSecond - 1
			if endSecond < 0 {
				angle = 0
				roundButton.initView(self)
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
			startButton.icon.image = image
			startButton.title.text = "START"
		}
		startButton.title.sizeToFit()
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
