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

	func Parse(_ xmlFile: String) {
		let parseXML = ParseXML()
		screenObjects = parseXML.Parse(xmlFile)
	}

	func DrawObject(_ object: Any, type: String, name: String, angle: CGFloat = 0, image: String = "", spec: String = "") {
		for screenObject in screenObjects {
			if screenObject.name == name {
				switch type {
				case "label":
					AddLabel(object as! UILabel, view: parentView, object: screenObject, spec: spec)
				case "image":
					AddImage(object as! UIImageView, view: parentView, object: screenObject, angle: angle, image: image)
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

	func AddLabel(_ label: UILabel, view: UIView, object: ScreenObject, spec: String, alpha:Double = 1.0) {
		label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		if spec == "" {
			label.text = object.text
		} else {
			label.text = spec
		}

		label.font = UIFont(name: object.font, size: object.size)
		label.textColor = color.UIColorFromHex(object.color, alpha: alpha)
		label.numberOfLines = object.line
		if object.width != 0 {
			let width = ScreenSize.instance.GetItemWidth(object.width)
			let height = ScreenSize.instance.GetItemWidth(object.height)

			label.frame = CGRect(x: 0, y: 0, width: width, height: height)
			label.lineBreakMode = NSLineBreakMode.byWordWrapping
			label.textAlignment = NSTextAlignment.center
		} else {
			label.sizeToFit()
		}

		if object.xPosition == -1 {
			let width = label.frame.width
			let screenWidth = ScreenSize.instance.GetCurrentWidth()
			label.frame.origin.x = (screenWidth - width) / 2
		} else {
			label.frame.origin.x = ScreenSize.instance.GetPositionX(object.xPosition)
		}
		label.frame.origin.y = ScreenSize.instance.GetPositionY(object.yPosition)

		view.addSubview(label)
	}

	func AddImage(_ imageView: UIImageView, view: UIView, object: ScreenObject, angle: CGFloat, image: String) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		imageView.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		if image == "" {
			imageView.image = object.icon
		} else {
			imageView.image = UIImage(named: image)
		}
		UIView.animate(withDuration: 2.0, animations: {
			imageView.transform = CGAffineTransform(rotationAngle: angle)
		})
		view.addSubview(imageView)
	}

	func AddButton(_ button: UIButton, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.setImage(object.icon, for: UIControlState())
		view.addSubview(button)
	}

	func AddBackground(_ background: UILabel, view: UIView, object: ScreenObject, alpha:Double = 1.0) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		background.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		background.backgroundColor = color.UIColorFromHex(object.color, alpha: alpha)
		view.addSubview(background)
	}

	func AddMainButton(_ button : MainButton, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.icon.image = object.icon
		button.title.text = object.text
		button.image = object.image
		button.initView()
		view.addSubview(button)
	}

	func AddRoundButton(_ button : RoundButton, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)

		let clicked = #selector(button.Clicked(_:))
		button.addTarget(button, action: clicked, for: UIControlEvents.touchUpInside)
		button.initView(parentController)
		view.addSubview(button)
	}
}
