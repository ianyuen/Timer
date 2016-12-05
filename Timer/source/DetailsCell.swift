//
//  DetailsCell.swift
//  Timer
//
//  Created by ian on 12/4/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func initView() {
		objectManager.parent = contentView
		objectManager.Parse("DetailsCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				AddLabel(object)
			case "image":
				AddImage(object)
			case "textBox":
				AddTextBox(object)
			case "background":
				AddBackground(object)
			case "roundSecondsGroup":
				AddRoundSecondsGroup(object)
			default: break
			}
		}
	}

	func AddLabel(_ object: ScreenObject) {
		switch object.name {
		case "totalText":
			objectManager.AddLabel(totalText, view: contentView, object: object)
		case "roundsTitle":
			objectManager.AddLabel(roundsTitle, view: contentView, object: object)
		case "profileText":
			objectManager.AddLabel(profileText, view: contentView, object: object)
		case "trainingTime":
			objectManager.AddLabel(trainingTime, view: contentView, object: object)
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
			objectManager.AddTextBox(roundsNumber, view: contentView, object: object)
		default: break
		}
	}

	func AddBackground(_ object: ScreenObject) {
		switch object.name {
		case "totalBack":
			objectManager.AddBackground(totalBack, view: contentView, object: object)
		case "profileBack":
			objectManager.AddBackground(profileBack, view: contentView, object: object)
		default: break
		}
	}

	func AddRoundSecondsGroup(_ object: ScreenObject) {
		switch object.name {
		case "redTime":
			objectManager.AddRoundSecondsGroup(group: redTime, view: contentView, object: object)
		case "roundTime":
			objectManager.AddRoundSecondsGroup(group: roundTime, view: contentView, object: object)
		case "warmUpTime":
			objectManager.AddRoundSecondsGroup(group: warmUpTime, view: contentView, object: object)
		case "coolDownTime":
			objectManager.AddRoundSecondsGroup(group: coolDownTime, view: contentView, object: object)
		default: break
		}
	}
}
