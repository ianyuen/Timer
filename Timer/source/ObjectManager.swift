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
	var screenObjects = [ScreenObject]()

	func Parse(_ xmlFile: String) {
		let parseXML = ParseXML()
		screenObjects = parseXML.Parse(xmlFile)
	}

	func DrawScreen(_ view: UIView) {
		for object in screenObjects {
			DrawObject(view, object: object)
		}
	}

	func DrawObject(_ view: UIView, object: ScreenObject) {
		switch object.type {
		case "background":
			AddBackground(view, object: object)
		default:
			break
		}
	}

	func AddBackground(_ view: UIView, object: ScreenObject, alpha:Double = 1.0) {
		let positionX = ScreenSize.instance.getPositionX(object.xPosition)
		let positionY = ScreenSize.instance.getPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.getItemWidth(object.width)
		let itemHeight = ScreenSize.instance.getItemHeight(object.height)
		
		let background = UILabel()
		background.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		background.backgroundColor = color.UIColorFromHex(object.color, alpha: alpha)
		view.addSubview(background)
	}
}
