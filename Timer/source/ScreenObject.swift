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

	var size: CGFloat = 0
	var width: CGFloat = 0
	var height: CGFloat = 0
	var xPosition: CGFloat = 0
	var yPosition: CGFloat = 0

	var icon = UIImage()
	var line: Int = 1
	var color: UInt32 = 0
	var clicked: Selector? = nil
}
