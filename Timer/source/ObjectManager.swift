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
	var parent = UIView()
	var controller = UIViewController()

	private var screenObjects = [ScreenObject]()

	func Parse(_ xmlFile: String) {
		let parseXML = ParseXML()
		screenObjects = parseXML.Parse(xmlFile)
	}

	func GetObjects() -> [ScreenObject] {
		return screenObjects
	}

	func DrawObject(_ object: Any, type: String, name: String, angle: CGFloat = 0, image: String = "", spec: String = "") {
		for screenObject in screenObjects {
			if screenObject.name == name {
				switch type {
				case "label":
					AddLabel(object as! UILabel, view: parent, object: screenObject, spec: spec)
				case "image":
					AddImage(object as! UIImageView, view: parent, object: screenObject, angle: angle, image: image)
				case "button":
					AddButton(object as! UIButton, view: parent, object: screenObject)
				case "background":
					AddBackground(object as! UILabel , view: parent, object: screenObject)
				case "mainButton":
					AddMainButton(object as! MainButton, view: parent, object: screenObject)
				case "roundButton":
					AddRoundButton(object as! RoundButton, view: parent, object: screenObject)
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
					result = result + parent.frame.width
				case "height":
					result = result + parent.frame.height
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

	func AddText(_ textView: UITextView, view: UIView, object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		textView.isEditable = false
		textView.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		textView.text = object.text
		textView.font = UIFont(name: object.font, size: object.size)
		let color = Color()
		//textView.textColor = constant.UIColorFromHex(color)
		if object.color == 0 {
			textView.backgroundColor = UIColor.clear
		} else {
			textView.backgroundColor = color.UIColorFromHex(object.color)
		}
		view.addSubview(textView)
	}

	func AddLabel(_ label: UILabel, view: UIView, object: ScreenObject, spec: String = "", alpha:Double = 1.0) {
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
			label.frame.origin.x = (parent.frame.width - width) / 2
		} else {
			label.frame.origin.x = ScreenSize.instance.GetPositionX(object.xPosition)
		}
		if object.yPosition == -1 {
			let height = label.frame.height
			label.frame.origin.y = (parent.frame.height - height) / 2
		} else {
			label.frame.origin.y = ScreenSize.instance.GetPositionY(object.yPosition)
		}
		view.addSubview(label)
	}

	func AddImage(_ imageView: UIImageView, view: UIView, object: ScreenObject, angle: CGFloat = 0, image: String = "") {
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
		imageView.transform = CGAffineTransform(rotationAngle: angle)
		view.addSubview(imageView)
	}

	func AddButton(_ button: UIButton, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.setImage(object.icon, for: UIControlState())
		if object.clicked != nil {
			button.addTarget(controller, action: object.clicked!, for: UIControlEvents.touchUpInside)
		}
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

	func AddNewButton(_ button : NewButton, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		
		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.SetController(controller)
		button.title.text = object.text
		button.addTarget(controller, action: object.clicked!, for: UIControlEvents.touchUpInside)
		button.initView()
		view.addSubview(button)
	}

	func AddBackButton(_ button : BackButton, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		
		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.SetController(controller)
		button.addTarget(controller, action: object.clicked!, for: UIControlEvents.touchUpInside)
		button.initView()
		view.addSubview(button)
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
		button.addTarget(controller, action: object.clicked!, for: UIControlEvents.touchUpInside)
		button.initView(controller)
		view.addSubview(button)
	}

	func AddRoundButton(_ button : RoundButton, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		button.addTarget(controller, action: object.clicked!, for: UIControlEvents.touchUpInside)
		button.initView()
		view.addSubview(button)
	}
}
