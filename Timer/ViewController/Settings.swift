//
//  Settings.swift
//  Timer
//
//  Created by ian on 11/30/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Settings: UIViewController {
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

	override var prefersStatusBarHidden: Bool {
		return true
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		return
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
				if object.name == "titleBack" {
					objectManager.AddBackground(titleBack, view: view, object: object)
				} else if object.name == "background" {
					objectManager.AddBackground(background, view: view, object: object)
				}
			case "newButton":
				if object.name == "newButton" {
					newButton.SetText(object.text)
					newButton.SetWidth(object.width)
					newButton.SetHeight(object.height)
					objectManager.AddButton(newButton, view: view, object: object)
				} else if object.name == "editButton" {
					editButton.SetText(object.text)
					editButton.SetWidth(object.width)
					editButton.SetHeight(object.height)
					objectManager.AddButton(editButton, view: view, object: object)
				} else if object.name == "weightButton" {
					weightButton.SetText(object.text)
					weightButton.SetWidth(object.width)
					weightButton.SetHeight(object.height)
					objectManager.AddButton(weightButton, view: view, object: object)
				}
			case "backButton":
				objectManager.AddBackButton(backButton, view: view, object: object)
			case "scrollView":
				objectManager.AddScrollView(content, view: view, object: object)
			default: break
			}
		}
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
