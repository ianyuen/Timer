//
//  Settings.swift
//  Timer
//
//  Created by ian on 11/30/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Settings: ViewController {
	let objectManager = ObjectManager()

	let content = WorkoutCell()
	let titleBack = UILabel()
	let titleText = UILabel()
	let background = UILabel()
	let newButton = NewButton()
	let editButton = NewButton()
	let backButton = BackButton()
	let weightButton = NewButton()

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)
		initView()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
    }

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Settings")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				objectManager.AddLabel(titleText, view: view, object: object)
			case "background":
				DrawBackground(object)
			case "newButton":
				if object.name == "newButton" {
					DrawNewButton(newButton, object: object)
				} else if object.name == "editButton" {
					DrawNewButton(editButton, object: object)
				} else if object.name == "weightButton" {
					DrawNewButton(weightButton, object: object)
				}
			case "backButton":
				objectManager.AddButton(backButton, view: view, object: object)
			case "scrollView":
				objectManager.AddScrollView(content, view: view, object: object)
			default: break
			}
		}
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "titleBack":
			objectManager.AddBackground(titleBack, view: view, object: object)
		case "background":
			objectManager.AddBackground(background, view: view, object: object)
		default: break
		}
	}

	func DrawNewButton(_ button: NewButton, object: ScreenObject) {
		button.SetText(object.text)
		button.SetWidth(object.width)
		button.SetHeight(object.height)
		objectManager.AddButton(button, view: view, object: object)
	}

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showMain", sender: self)
	}

	func btnNewClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showDetails", sender: self)
	}

	func btnEditClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showDetails", sender: self)
	}

	func btnWeightClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showDetails", sender: self)
	}
}
