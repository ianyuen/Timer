//
//  History.swift
//  Timer
//
//  Created by ian on 12/12/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class History: UIViewController {
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
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("History")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				DrawBackground(object)
			default: break
			}
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
