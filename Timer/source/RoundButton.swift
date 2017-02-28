//
//  StartButton.swift
//  Timer
//
//  Created by ian on 11/23/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class RoundButton: Button {
	let endTime = UILabel()
	let background1 = UIImageView()
	let background2 = UIImageView()
	let background3 = UIImageView()
	
	var width: CGFloat = 0
	var height: CGFloat = 0
	var drawing = false
	var objectManager = ObjectManager()

	private var image = "warm"
	private var controller = UIViewController()

	override func initView () {
		objectManager.parent = self
		objectManager.Parse("RoundButton")
		objectManager.DrawObject(background1, type: "image", name: "background1")
		objectManager.DrawObject(background2, type: "image", name: "background2")
		objectManager.DrawObject(background3, type: "image", name: "background3")
		objectManager.DrawObject(endTime, type: "label", name: "endTime")
	}

	func SetAnim(_ value: String) {
		image = value
	}

	func SetController(_ viewController: UIViewController) {
		controller = viewController
	}

	func DrawCircle(_ angle: CGFloat) {
		let background4 = UIImageView()
		objectManager.DrawObject(background4, type: "image", name: "background4", angle: angle, image: image)
		objectManager.DrawObject(background1, type: "image", name: "background1")
		objectManager.DrawObject(background3, type: "image", name: "background3")
		objectManager.DrawObject(endTime, type: "label", name: "endTime")
	}

	func Clicked(_ sender:UIButton!) {
		drawing = !drawing
	}
}
