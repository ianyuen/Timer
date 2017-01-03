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

	let totalText = TextBox()
	let profileText = TextBox()

	let roundsTitle = UILabel()
	let roundsNumber = TextBox()
	let trainingTime = UILabel()

	let redTime = RoundSecondsGroup()
	let roundTime = RoundSecondsGroup()
	let warmUpTime = RoundSecondsGroup()
	let coolDownTime = RoundSecondsGroup()

	let sound = ComboButton()
	let soundText = UILabel()
	let soundExpand = UILabel()
	
	let soundNo = Button()
	let soundGym = Button()
	let soundHuman = Button()
	let soundBoxing = Button()
	let soundDigital = Button()

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

		soundExpand.isHidden = true
		soundNo.isHidden = true
		soundGym.isHidden = true
		soundHuman.isHidden = true
		soundBoxing.isHidden = true
		soundDigital.isHidden = true

		var contentHeight: CGFloat = 0
		for view in subviews {
			let viewHeight = view.frame.origin.y + view.frame.height
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		contentSize = CGSize(width: frame.width, height: contentHeight)
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
			objectManager.AddTextBox(totalText, view: self, object: object)
		case "round1Text":
			objectManager.AddTextBox(round1Text, view: self, object: object)
		case "round2Text":
			objectManager.AddTextBox(round2Text, view: self, object: object)
		case "profileText":
			objectManager.AddTextBox(profileText, view: self, object: object)
		case "roundsNumber":
			objectManager.AddTextBox(roundsNumber, view: self, object: object)
		default: break
		}
	}

	func AddComboBox(_ object: ScreenObject) {
		switch object.name {
		case "sound":
			objectManager.AddComboButton(sound, parent: self, object: object)
		case "vibrate":
			objectManager.AddComboButton(vibrate, parent: self, object: object)
		case "routine":
			objectManager.AddComboButton(routine, parent: self, object: object)
		case "motivation":
			objectManager.AddComboButton(motivation, parent: self, object: object)
		default: break
		}
	}

	func AddBackground(_ object: ScreenObject) {
		switch object.name {
		case "soundExpand":
			objectManager.AddBackground(soundExpand, parent: self, object: object)
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

	func AddButton(_ object: ScreenObject) {
		switch object.name {
		case "saveButton":
			saveButton.SetText(object.text)
			saveButton.SetWidth(object.width)
			saveButton.SetHeight(object.height)
			objectManager.AddButton(saveButton, parent: self, object: object)
		case "deleteButton":
			deleteButton.SetText(object.text)
			deleteButton.SetWidth(object.width)
			deleteButton.SetHeight(object.height)
			objectManager.AddButton(deleteButton, parent: self, object: object)
		case "soundNo":
			objectManager.AddButton(soundNo, parent: self, object: object, target: self)
		case "soundGym":
			objectManager.AddButton(soundGym, parent: self, object: object, target: self)
		case "soundHuman":
			objectManager.AddButton(soundHuman, parent: self, object: object, target: self)
		case "soundBoxing":
			objectManager.AddButton(soundBoxing, parent: self, object: object, target: self)
		case "soundDigital":
			objectManager.AddButton(soundDigital, parent: self, object: object, target: self)
		default: break
		}
	}

	func btnSoundClicked(_ sender:UIButton!) {
		soundExpand.isHidden = !soundExpand.isHidden
		soundNo.isHidden = !soundNo.isHidden
		soundGym.isHidden = !soundGym.isHidden
		soundHuman.isHidden = !soundHuman.isHidden
		soundBoxing.isHidden = !soundBoxing.isHidden
		soundDigital.isHidden = !soundDigital.isHidden
	}

	func btnVibrateClicked(_ sender:UIButton!) {
	}

	func btnRoutineClicked(_ sender:UIButton!) {
	}

	func btnMotivationClicked(_ sender:UIButton!) {
	}

	func HideSoundExpand(_ hidden: Bool) {
		soundExpand.isHidden = hidden
		soundNo.isHidden = hidden
		soundGym.isHidden = hidden
		soundHuman.isHidden = hidden
		soundBoxing.isHidden = hidden
		soundDigital.isHidden = hidden
	}
	func soundNoClicked(_ sender: Button) {
		HideSoundExpand(true)
		sound.SetTitle("No")
	}

	func soundGymClicked(_ sender: Button) {
		HideSoundExpand(true)
		sound.SetTitle("Gym")
	}

	func soundHumanClicked(_ sender: Button) {
		HideSoundExpand(true)
		sound.SetTitle("Human")
	}

	func soundBoxingClicked(_ sender: Button) {
		HideSoundExpand(true)
		sound.SetTitle("Boxing")
	}

	func soundDigitalClicked(_ sender: Button) {
		HideSoundExpand(true)
		sound.SetTitle("Digital")
	}

	func childrenButtonClicked(_ sender: UIButton) {
		HideSoundExpand(true)
	}
}
