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
					AddLabel(object as! UILabel, parent: parent, object: screenObject, spec: spec)
				case "image":
					AddImage(object as! UIImageView, view: parent, object: screenObject, angle: angle, image: image)
				case "button":
					AddButton(object as! Button, view: parent, object: screenObject)
				case "background":
					AddBackground(object as! UILabel , parent: parent, object: screenObject)
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

	func CGFloatFromString(_ source: String, object: UIView) -> CGFloat {
		var isAdd = true
		var isWidth = true
		var result: CGFloat = 0
		let valueArray = source.characters.split{$0 == " "}.map(String.init)
		for value in valueArray {
			if value == "centerWidth" {
				result = (ScreenSize.instance.GetCurrentWidth() - object.frame.width) / 2
			} else if value == "centerHeight" {
				result = (parent.frame.height - object.frame.height) / 2
			} else {
				switch value {
				case "+":
					isAdd = true
				case "-":
					isAdd = false
				case "width":
					if isAdd {
						result = result + object.frame.width
					} else {
						result = result - object.frame.width
					}
					isWidth = true
				case "height":
					if isAdd {
						result = result + object.frame.height
					} else {
						result = result + object.frame.height
					}
					isWidth = false

				case "parentWidth":
					if isAdd {
						result = result + parent.frame.width
					} else {
						result = result - parent.frame.width
					}
					isWidth = true
				case "parentHeight":
					if isAdd {
						result = result + parent.frame.height
					} else {
						result = result - parent.frame.height
					}
					isWidth = false

				default:
					let number = StringToCGFloat(value)
					var convert: CGFloat = 0
					if isWidth {
						convert = ScreenSize.instance.GetItemWidth(number)
					} else {
						convert = ScreenSize.instance.GetItemHeight(number)
					}
					if isAdd {
						result = result + convert
					} else {
						result = result - convert
					}
				}
			}
		}

		return result
	}

	func AddLine(_ line: SingleLine, parent: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		line.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		line.setNeedsDisplay()
		parent.addSubview(line)
	}

	func AddView(_ view: View, parent: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		
		view.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		view.initView()
		parent.addSubview(view)
	}

	func AddLabel(_ label: UILabel, parent: UIView, object: ScreenObject, spec: String = "", alpha:Double = 1.0) {
		label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		if spec == "" {
			label.text = object.text
		} else {
			label.text = spec
		}

		label.font = UIFont(name: object.font, size: object.size)
		label.textColor = color.UIColorFromHex(object.textColor, alpha: alpha)
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
		if object.posXRaw != "" {
			label.frame.origin.x = CGFloatFromString(object.posXRaw, object: label)
		}
		if object.posYRaw != "" {
			label.frame.origin.y = CGFloatFromString(object.posYRaw, object: label)
		}

		parent.addSubview(label)
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

	func AddPicker(_ picker: UIPickerView, view: UIView, object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height) * 4

		picker.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		view.addSubview(picker)
	}

	func AddButton(_ button: Button, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		
		button.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		if object.clicked != nil {
			button.addTarget(controller, action: object.clicked!, for: UIControlEvents.touchUpInside)
		}
		button.initView()
		if object.title != "" {
			button.setTitle(object.title, for: UIControlState.normal)
			button.setTitleColor(color.UIColorFromHex(object.textColor), for: UIControlState.normal)
			button.titleLabel!.font =  UIFont(name: object.font, size: object.size)
			button.sizeToFit()
		}
		if object.posXRaw != "" {
			button.frame.origin.x = CGFloatFromString(object.posXRaw, object: button)
		}
		if object.posYRaw != "" {
			button.frame.origin.y = CGFloatFromString(object.posYRaw, object: button)
		}
		view.addSubview(button)
	}

	func AddBackground(_ background: UILabel, parent: UIView, object: ScreenObject, alpha:Double = 1.0) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		
		background.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		background.backgroundColor = color.UIColorFromHex(object.backColor, alpha: alpha)
		if object.round {
			background.layer.masksToBounds = true
			if background.frame.width < 50 {
				background.layer.cornerRadius = 4
			} else if background.frame.width < 100 {
				background.layer.cornerRadius = 6
			} else if background.frame.width < 150 {
				background.layer.cornerRadius = 8
			} else {
				background.layer.cornerRadius = 8
			}
		}
		parent.addSubview(background)
	}

	func AddTextBox(_ textBox: TextBox, view: UIView, object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)

		textBox.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		textBox.SetText(object.text)
		textBox.SetFont(object.font, size: object.size)
		textBox.SetWidth(object.width)
		textBox.SetHeight(object.height)
		textBox.SetBackColor(object.backColor)
		textBox.initView()

		view.addSubview(textBox)
	}

	func AddTextView(_ textView: UITextView, view: UIView, object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		textView.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		
		textView.text = object.text
		textView.font = UIFont(name: object.font, size: object.size)
		textView.isEditable = false
		textView.isScrollEnabled = false
		let color = Color()
		textView.textColor = color.UIColorFromHex(0xffffff)
		if object.backColor == 0x373639 {
			textView.backgroundColor = UIColor.clear
		} else {
			textView.backgroundColor = color.UIColorFromHex(object.backColor)
		}
		if object.posXRaw != "" {
			//let x = CGFloatFromString(object.posXRaw, object: textView)
			//let y = CGFloatFromString(object.posYRaw, object: textView)
			textView.contentOffset = CGPoint(x: -10, y: 5)
		}
		view.addSubview(textView)
	}

	func AddTextField(_ textField: UITextField, view: UIView, object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		textField.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		textField.font = UIFont(name: object.font, size: object.size)
		textField.text = object.text
		
		let color = Color()
		textField.textColor = color.UIColorFromHex(object.textColor, alpha: 1.0)
		textField.backgroundColor = color.UIColorFromHex(0x373639, alpha: 0)
		textField.textAlignment = NSTextAlignment.center
		view.addSubview(textField)
	}

	func AddScrollView(_ content: ScrollView, view: UIView, object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		content.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		content.initView()
		view.addSubview(content)
	}

	func AddComboButton(_ comboBox: ComboButton, parent: UIView, object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		comboBox.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		comboBox.SetFont(object.font, size: object.size)
		comboBox.SetWidth(object.width)
		comboBox.SetHeight(object.height)
		comboBox.SetChildrens(object.children)
		comboBox.addTarget(parent, action: object.clicked!, for: UIControlEvents.touchUpInside)
		comboBox.initView()
		
		parent.addSubview(comboBox)
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

	func AddRoundSecondsGroup(group: RoundSecondsGroup, view: UIView, object: ScreenObject) {
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)

		group.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		group.SetTitle(object.text)
		group.SetImage(object.icon)
		group.initView()
		view.addSubview(group)
	}
}
