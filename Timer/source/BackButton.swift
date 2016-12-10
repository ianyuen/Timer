//
//  BackButton.swift
//  Timer
//
//  Created by ian on 12/1/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class BackButton: UIButton {
	private var controller = UIViewController()

	let image = UIImageView()
	let title = UILabel()

	func initView() {
		let objectManager = ObjectManager()
		objectManager.parent = self
		objectManager.controller = controller
		objectManager.Parse("BackButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "image":
				objectManager.AddImage(image, view: self, object: object)
			case "label":
				objectManager.AddLabel(title, view: self, object: object)
			default: break
			}
		}
	}

	func SetController(_ viewController: UIViewController) {
		controller = viewController
	}
}