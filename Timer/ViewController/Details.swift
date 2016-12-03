//
//  Details.swift
//  Timer
//
//  Created by ian on 12/3/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Details: UIViewController {
	let objectManager = ObjectManager()

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

	override var prefersStatusBarHidden: Bool {
		return true
	}

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Details")
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
			case "backButton":
				objectManager.AddBackButton(backButton, view: view, object: object)
			default: break
			}
		}
	}

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showSettings", sender: self)
	}
}
