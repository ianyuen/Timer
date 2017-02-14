//
//  ScreenObject.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit
import Foundation

class ScreenObject {
	var type = ""
	var name = ""
	var text = ""
	var font = ""
	var image = ""
	var title = ""
	var posXRaw = ""
	var posYRaw = ""
	var widthRaw = ""
	var heightRaw = ""

	var size: CGFloat = 0
	var width: CGFloat = 0
	var height: CGFloat = 0
	var xPosition: CGFloat = 0
	var yPosition: CGFloat = 0
	var rowHeight: CGFloat = 0

	var icon = UIImage()
	var line: Int = 1
	var round = false
	var clicked: Selector? = nil

	var backColor: UInt32 = 0xf9aa43
	var lineColor: UInt32 = 0xffffff
	var textColor: UInt32 = 0x373639
}
