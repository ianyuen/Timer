//
//  Main.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Main: UIViewController {
	let round = UILabel()
	let endTime = UILabel()
	let background = UILabel()
	let roundButton = RoundButton()
	let screenTitle = UILabel()
	let historyButton = UIButton()
	let settingsButton = UIButton()
	let titleBackground = UILabel()

	var angle: CGFloat = 0.0

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

	func update() {
		if (roundButton.drawing) {
			roundButton.DrawCircle(angle)
			angle = angle + CGFloat.pi / 30
		} else {
			angle = 0
		}
	}

	func initView() {
		let objectManager = ObjectManager(view: view, controller: self)
		objectManager.Parse("Main")
		objectManager.DrawObject(background, type: "background", name: "background")
		objectManager.DrawObject(round, type: "label", name: "round")
		objectManager.DrawObject(screenTitle, type: "label", name: "title")
		objectManager.DrawObject(historyButton, type: "button", name: "historyButton")
		objectManager.DrawObject(settingsButton, type: "button", name: "settingsButton")

		objectManager.DrawObject(titleBackground, type: "background", name: "titleBackground")
		objectManager.DrawObject(endTime, type: "label", name: "endTime")

		objectManager.DrawObject(roundButton, type: "roundButton", name: "roundButton")

		let resetButton = MainButton(self)
		let startButton = MainButton(self)
		objectManager.DrawObject(startButton, type: "mainButton", name: "startButton")
		objectManager.DrawObject(resetButton, type: "mainButton", name: "resetButton")
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
