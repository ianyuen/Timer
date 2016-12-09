//
//  DetailsCell.swift
//  Timer
//
//  Created by ian on 12/4/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class DetailsCell: ScrollView {
	let objectManager = ObjectManager()

	let totalBack = UILabel()
	let totalText = UILabel()

	let profileBack = UILabel()
	let profileText = UILabel()

	let roundsTitle = UILabel()
	let roundsNumber = TextBox()
	let trainingTime = UILabel()

	let redTime = RoundSecondsGroup()
	let roundTime = RoundSecondsGroup()
	let warmUpTime = RoundSecondsGroup()
	let coolDownTime = RoundSecondsGroup()

	let sound = ComboBox()
	let vibrate = ComboBox()
	let routine = ComboBox()
	let motivation = ComboBox()

	let exercise = UILabel()

	let round1Back = UILabel()
	let round1Text = UILabel()
	let round1Title = UILabel()

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		DismissKeyboard()
	}

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("DetailsCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				AddLabel(object)
			case "image":
				AddImage(object)
			case "textBox":
				AddTextBox(object)
			case "comboBox":
				AddComboBox(object)
			case "background":
				AddBackground(object)
			case "roundSecondsGroup":
				AddRoundSecondsGroup(object)
			default: break
			}
		}

		contentSize = CGSize(width: frame.width, height: 2500)
	}

	func AddLabel(_ object: ScreenObject) {
		switch object.name {
		case "totalText":
			objectManager.AddLabel(totalText, view: self, object: object)
		case "roundsTitle":
			objectManager.AddLabel(roundsTitle, view: self, object: object)
		case "profileText":
			objectManager.AddLabel(profileText, view: self, object: object)
		case "trainingTime":
			objectManager.AddLabel(trainingTime, view: self, object: object)
		case "exercise":
			objectManager.AddLabel(exercise, view: self, object: object)
		case "round1Text":
			objectManager.AddLabel(round1Text, view: self, object: object)
		case "round1Title":
			objectManager.AddLabel(round1Title, view: self, object: object)

		default: break
		}
	}

	func AddImage(_ object: ScreenObject) {
		switch object.name {
		default: break
		}
	}

	func AddTextBox(_ object: ScreenObject) {
		switch object.name {
		case "roundsNumber":
			objectManager.AddTextBox(roundsNumber, view: self, object: object)
		default: break
		}
	}

	func AddComboBox(_ object: ScreenObject) {
		switch object.name {
		case "sound":
			objectManager.AddComboBox(sound, view: self, object: object)
		case "vibrate":
			objectManager.AddComboBox(vibrate, view: self, object: object)
		case "routine":
			objectManager.AddComboBox(routine, view: self, object: object)
		case "motivation":
			objectManager.AddComboBox(motivation, view: self, object: object)
		default: break
		}
	}

	func AddBackground(_ object: ScreenObject) {
		switch object.name {
		case "totalBack":
			objectManager.AddBackground(totalBack, view: self, object: object)
		case "profileBack":
			objectManager.AddBackground(profileBack, view: self, object: object)
		case "round1Back":
			objectManager.AddBackground(round1Back, view: self, object: object)
		default: break
		}
	}

	func AddRoundSecondsGroup(_ object: ScreenObject) {
		switch object.name {
		case "redTime":
			objectManager.AddRoundSecondsGroup(group: redTime, view: self, object: object)
		case "roundTime":
			objectManager.AddRoundSecondsGroup(group: roundTime, view: self, object: object)
		case "warmUpTime":
			objectManager.AddRoundSecondsGroup(group: warmUpTime, view: self, object: object)
		case "coolDownTime":
			objectManager.AddRoundSecondsGroup(group: coolDownTime, view: self, object: object)
		default: break
		}
	}
}
