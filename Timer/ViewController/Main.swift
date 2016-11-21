//
//  Main.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Main: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.setStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.setCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.setCurrentHeight(self.view.frame.size.height)
		initView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func initView() {
		let objectManager = ObjectManager()
		objectManager.Parse("Main")
		objectManager.DrawScreen(view)
	}
}
