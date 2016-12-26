//
//  History.swift
//  Timer
//
//  Created by ian on 12/12/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class History: ViewController {
	let objectManager = ObjectManager()

	let content = HistoryScroll()
	let titleText = UILabel()
	let backButton = BackButton()
	let background = UILabel()
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

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showMain", sender: self)
	}

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("History")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				objectManager.AddLabel(titleText, view: view, object: object)
			case "backButton":
				DrawButton(object)
			case "scrollView":
				objectManager.AddScrollView(content, view: view, object: object)
			case "background":
				DrawBackground(object)
			case "newButton":
				weightButton.SetText(object.text)
				weightButton.SetWidth(object.width)
				weightButton.SetHeight(object.height)
				objectManager.AddButton(weightButton, view: view, object: object)
			default: break
			}
		}
	}

	func DrawButton(_ object: ScreenObject) {
		switch object.name {
		case "backButton":
			objectManager.AddButton(backButton, view: view, object: object)
		default: break
		}
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "background":
			objectManager.AddBackground(background, view: view, object: object)
		default: break
		}
	}
}
