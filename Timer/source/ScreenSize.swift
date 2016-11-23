//
//  ScreenSize.swift
//  Timer
//
//  Created by ian on 11/21/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit
import Foundation

class ScreenSize {
	static let instance = ScreenSize()

	let defaultWidth: CGFloat = 1242
	let defaultHeight: CGFloat = 2208

	var statusHeight: CGFloat = 0
	var currentWidth: CGFloat = 0
	var currentHeight: CGFloat = 0

	func GetStatusHeight() -> CGFloat {
		return statusHeight
	}

	func SetStatusHeight(_ height: CGFloat) -> Void {
		statusHeight = height
	}

	func GetCurrentWidth() -> CGFloat {
		return currentWidth
	}

	func SetCurrentWidth(_ width: CGFloat) -> Void {
		currentWidth = width
	}

	func GetCurrentHeight() -> CGFloat {
		return currentHeight
	}

	func SetCurrentHeight(_ height: CGFloat) -> Void {
		currentHeight = height
	}

	func GetPositionX(_ positionX:CGFloat) ->  CGFloat {
		return (currentWidth * positionX) / defaultWidth
	}

	func GetPositionY(_ positionY:CGFloat) ->  CGFloat {
		return (currentHeight * positionY) / defaultHeight
	}

	func GetItemWidth(_ itemWidth:CGFloat) ->  CGFloat {
		return (currentWidth * itemWidth) / defaultWidth
	}

	func GetItemHeight(_ itemHeight:CGFloat) ->  CGFloat {
		return (currentHeight * itemHeight) / defaultHeight
	}
}
