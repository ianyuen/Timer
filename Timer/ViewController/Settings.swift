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

	let titleBack = UILabel()
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

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Settings")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				if object.name == "titleBack" {
					objectManager.AddBackground(titleBack, view: view, object: object)
				} else if object.name == "background" {
					objectManager.AddBackground(background, view: view, object: object)
				}
			case "newButton":
				if object.name == "newButton" {
					objectManager.AddNewButton(newButton, view: view, object: object)
				} else if object.name == "editButton" {
					objectManager.AddNewButton(editButton, view: view, object: object)
				} else if object.name == "weightButton" {
					objectManager.AddNewButton(weightButton, view: view, object: object)
				}
			case "backButton":
				objectManager.AddBackButton(backButton, view: view, object: object)
			default: break
			}
		}
	}

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showMain", sender: self)
	}
}
