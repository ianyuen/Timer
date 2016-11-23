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
			case "icon":
				object.icon = string
			case "posX":
				object.xPosition = string
			case "posY":
				object.yPosition = string
			case "width":
				object.width = string
			case "height":
				object.height = string

			case "size":
				object.size = CGFloat(NumberFormatter().number(from: string)!)

			case "color":
				object.color = UInt32(string, radix: 16)!

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
