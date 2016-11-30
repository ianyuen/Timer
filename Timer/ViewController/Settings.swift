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

	let background = UILabel()

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
		objectManager.parentView = view
		objectManager.parentController = self
		objectManager.Parse("Settings")
		objectManager.DrawObject(background, type: "background", name: "background")
	}
}
