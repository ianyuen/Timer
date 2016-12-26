//
//  Details.swift
//  Timer
//
//  Created by ian on 12/3/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Details: ViewController {
	let objectManager = ObjectManager()

	let content = DetailsCell()
	let titleBack = UILabel()
	let titleText = UILabel()
	let background = UILabel()
	let backButton = BackButton()

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)
		initView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		DismissKeyboard()
	}

	func DismissKeyboard() {
		view.endEditing(true)
	}

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Details")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				DrawLabel(object)
			case "backButton":
				objectManager.AddButton(backButton, view: view, object: object)
			case "scrollView":
				objectManager.AddScrollView(content, view: view, object: object)
			case "background":
				DrawBackground(object)
			default: break
			}
		}
	}

	func DrawLabel(_ object: ScreenObject) {
		switch object.name {
		case "titleText":
			objectManager.AddLabel(titleText, view: view, object: object)
		default: break
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

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showSettings", sender: self)
	}
}
