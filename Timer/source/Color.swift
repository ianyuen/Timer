//
//  Color.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit
import Foundation

class Color {
	let white:UInt32 = 0xffffff
	let citrus:UInt32 = 0x373639
	let coralRed:UInt32 = 0xF94343
	let seaBuckthorn:UInt32 = 0xed9b3f

	func GetColor(_ value: String) -> UInt32 {
		switch value {
		case "0xffffff":
			return white
		case "0x373639":
			return citrus
		case "0xF94343":
			return coralRed
		case "0xed9b3f":
			return seaBuckthorn
		default:
			return coralRed
		}
	}

	func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
		let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 256.0
		let green = CGFloat((rgbValue & 0xFF00) >> 8) / 256.0
		let blue = CGFloat(rgbValue & 0xFF) / 256.0
		
		return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
	}
}
