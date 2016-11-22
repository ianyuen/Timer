//
//  ObjectManager.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit
import Foundation

class ObjectManager {
	let color = Color()
	var parentView = UIView()
	var parentController = UIViewController()
	var screenObjects = [ScreenObject]()

	init(view: UIView, controller: UIViewController) {
		parentView = view
		parentController = controller
	}

	func Parse(_ xmlFile: String) {
		let parseXML = ParseXML()
		screenObjects = parseXML.Parse(xmlFile)
	}

	func DrawObject(_ object: Any, type: String, name: String) {
		for screenObject in screenObjects {
			if screenObject.name == name {
				switch type {
				case "background":
					AddBackground(object as! UILabel , view: parentView, object: screenObject)
				default: break
				}
			}
		}
	}

	func AddBackground(_ background: UILabel, view: UIView, object: ScreenObject, alpha:Double = 1.0) {
		let positionX = ScreenSize.instance.getPositionX(object.xPosition)
		let positionY = ScreenSize.instance.getPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.getItemWidth(object.width)
		let itemHeight = ScreenSize.instance.getItemHeight(object.height)
		
		background.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		background.backgroundColor = color.UIColorFromHex(object.color, alpha: alpha)
		view.addSubview(background)
	}
}