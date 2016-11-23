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
				case "label":
					AddLabel(object as! UILabel, view: parentView, object: screenObject)
				case "image":
					AddImage(object as! UIImageView, view: parentView, object: screenObject)
				case "button":
					AddButton(object as! UIButton, view: parentView, object: screenObject)
				case "background":
					AddBackground(object as! UILabel , view: parentView, object: screenObject)
				case "mainButton":
					AddMainButton(object as! MainButton, view: parentView, object: screenObject)
				case "roundButton":
					AddRoundButton(object as! RoundButton, view: parentView, object: screenObject)
				default: break
				}
			}
		}
	}

	func StringToCGFloat(_ value: String) -> CGFloat {
		let result = NumberFormatter().number(from: value)
		if result != nil {
			return CGFloat(result!)
		} else {
			return 0
		}
	}
	
	func CGFloatFromString(_ value: String, xPosition: CGFloat = 0, yPosition: CGFloat = 0) -> CGFloat {
		var isAdd = true
		var result: CGFloat = 0
		let valueArray = value.characters.split{$0 == " "}.map(String.init)
		for value in valueArray {
			if value == "centerWidth" {
				result = (ScreenSize.instance.GetCurrentWidth() - xPosition) / 2
			} else if value == "centerHeight" {
				result = (ScreenSize.instance.GetCurrentHeight() - yPosition) / 2
			} else {
				switch value {
				case "+":
					isAdd = true
				case "-":
					isAdd = false
				case "width":
					result = result + parentView.frame.width
				case "height":
					result = result + parentView.frame.height
				case "screenWidth":
					result = result + ScreenSize.instance.defaultWidth
				case "screenHeight":
					result = result + ScreenSize.instance.defaultHeight
				default:
					let number = StringToCGFloat(value)
					if isAdd {
						result = result + number
					} else {
						result = result - number
					}
				}
			}
		}
		
		return result
	}

	func AddLabel(_ label: UILabel, view: UIView, object: ScreenObject, alpha:Double = 1.0) {
		label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		label.text = object.text
		label.font = UIFont(name: object.font, size: object.size)
		label.textColor = color.UIColorFromHex(object.color, alpha: alpha)
		label.sizeToFit()
		if object.xPosition == "centerWidth" {
			label.frame.origin.x = (parentView.frame.width - label.frame.width) / 2
		} else {
			label.frame.origin.x = CGFloatFromString(object.xPosition)
		}

		let objectY = CGFloatFromString(object.yPosition)
		label.frame.origin.y = ScreenSize.instance.GetPositionY(objectY)
		view.addSubview(label)
	}

	func AddImage(_ imageView: UIImageView, view: UIView, object: ScreenObject) {
		let objectWidth = CGFloatFromString(object.width)
		let objectHeight = CGFloatFromString(object.height)
		let itemWidth = ScreenSize.instance.GetItemWidth(objectWidth)
		let itemHeight = ScreenSize.instance.GetItemHeight(objectHeight)

		let objectX = CGFloatFromString(object.xPosition)
		let objectY = CGFloatFromString(object.yPosition)
		let positionX = ScreenSize.instance.GetPositionX(objectX)
		let positionY = ScreenSize.instance.GetPositionY(objectY)

		imageView.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		let image = UIImage(named: object.icon)
		imageView.image = image
		view.addSubview(imageView)
	}

	func AddButton(_ button: UIButton, view: UIView, object: ScreenObject) {
		let objectWidth = CGFloatFromString(object.width)
		let objectHeight = CGFloatFromString(object.height)
		let itemWidth = ScreenSize.instance.GetItemWidth(objectWidth)
		let itemHeight = ScreenSize.instance.GetItemHeight(objectHeight)

		let objectX = CGFloatFromString(object.xPosition)
		let objectY = CGFloatFromString(object.yPosition)
		let positionX = ScreenSize.instance.GetPositionX(objectX)
		let positionY = ScreenSize.instance.GetPositionY(objectY)

		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		let image = UIImage(named: object.icon)
		button.setImage(image, for: UIControlState())
		view.addSubview(button)
	}

	func AddBackground(_ background: UILabel, view: UIView, object: ScreenObject, alpha:Double = 1.0) {
		let objectWidth = CGFloatFromString(object.width)
		let objectHeight = CGFloatFromString(object.height)
		let itemWidth = ScreenSize.instance.GetItemWidth(objectWidth)
		let itemHeight = ScreenSize.instance.GetItemHeight(objectHeight)

		let objectX = CGFloatFromString(object.xPosition)
		let objectY = CGFloatFromString(object.yPosition)
		let positionX = ScreenSize.instance.GetPositionX(objectX)
		let positionY = ScreenSize.instance.GetPositionY(objectY)

		background.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		background.backgroundColor = color.UIColorFromHex(object.color, alpha: alpha)
		view.addSubview(background)
	}

	func AddMainButton(_ button : MainButton, view: UIView, object: ScreenObject) {
		let objectWidth = CGFloatFromString(object.width)
		let objectHeight = CGFloatFromString(object.height)
		let itemWidth = ScreenSize.instance.GetItemWidth(objectWidth)
		let itemHeight = ScreenSize.instance.GetItemHeight(objectHeight)

		let objectX = CGFloatFromString(object.xPosition)
		let objectY = CGFloatFromString(object.yPosition)
		let positionX = ScreenSize.instance.GetPositionX(objectX)
		let positionY = ScreenSize.instance.GetPositionY(objectY)

		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.title.text = object.text
		view.addSubview(button)
	}

	func AddRoundButton(_ button : RoundButton, view: UIView, object: ScreenObject) {
		let objectWidth = CGFloatFromString(object.width)
		let objectHeight = CGFloatFromString(object.height)
		let itemWidth = ScreenSize.instance.GetItemWidth(objectWidth)
		let itemHeight = ScreenSize.instance.GetItemHeight(objectHeight)
		
		let objectX = CGFloatFromString(object.xPosition)
		let objectY = CGFloatFromString(object.yPosition)
		let positionX = ScreenSize.instance.GetPositionX(objectX)
		let positionY = ScreenSize.instance.GetPositionY(objectY)
		
		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.initView()
		view.addSubview(button)
	}
}
