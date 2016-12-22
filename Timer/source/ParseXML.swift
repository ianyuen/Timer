//
//  ParseXML.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit
import Foundation

class ParseXML : NSObject, XMLParserDelegate {
	var isParsing: Bool = false
	var curElement: String = ""
	var didStartElement: Bool = false

	var object = ScreenObject()
	var screenObjects = [ScreenObject]()

	func Parse(_ xmlFile: String) -> [ScreenObject]{
		let path = Bundle.main.path(forResource: xmlFile, ofType: "xml")
		let data = try? Data.init(contentsOf: URL(fileURLWithPath: path!))
		let parser = XMLParser(data: data!)
		parser.delegate = self
		parser.parse()
		
		while isParsing {}
		return screenObjects
	}

	func StringToBool(_ value: String) -> Bool {
		switch value {
		case "true":
			return true
		case "false":
			return false
		default:
			return false
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
				result = -1
			} else if value == "centerHeight" {
				result = -1
			} else {
				switch value {
				case "+":
					isAdd = true
				case "-":
					isAdd = false
				case "width":
					result = result + object.width
				case "height":
					result = result + object.height
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

	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
		curElement = elementName
		didStartElement = true
		if elementName == "object" {
			object = ScreenObject()
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		if didStartElement {
			switch curElement {
			case "type":
				object.type = string
			case "name":
				object.name = string
			case "text":
				object.text = string
			case "font":
				object.font = string
			case "image":
				object.image = string
			case "title":
				object.title = string
			case "child":
				object.children.append(string)
			case "posXRaw":
				object.posXRaw = string
			case "posYRaw":
				object.posYRaw = string
			case "widthRaw":
				object.widthRaw = string
			case "heightRaw":
				object.heightRaw = string

			case "size":
				object.size = CGFloat(NumberFormatter().number(from: string)!)
			case "posX":
				object.xPosition = CGFloatFromString(string)
			case "posY":
				object.yPosition = CGFloatFromString(string)
			case "width":
				object.width = CGFloatFromString(string)
			case "height":
				object.height = CGFloatFromString(string)
			case "rowHeight":
				object.rowHeight = CGFloatFromString(string)

			case "icon":
				object.icon = UIImage(named: string)!
			case "line":
				object.line = Int(string, radix: 10)!
			case "round":
				object.round = StringToBool(string)
			case "clicked":
				object.clicked = NSSelectorFromString(string + ":")

			case "backColor":
				object.backColor = UInt32(string, radix: 16)!
			case "textColor":
				object.textColor = UInt32(string, radix: 16)!

			default: return
			}
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		didStartElement = false
		if elementName == "object" {
			screenObjects.append(object)
		} else if elementName == "view" {
			isParsing = false
		}
	}
}
