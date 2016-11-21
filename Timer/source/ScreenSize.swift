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

	func getStatusHeight() -> CGFloat {
		return statusHeight
	}

	func setStatusHeight(_ height: CGFloat) -> Void {
		statusHeight = height
	}

	func getCurrentWidth() -> CGFloat {
		return currentWidth
	}

	func setCurrentWidth(_ width: CGFloat) -> Void {
		currentWidth = width
	}

	func getCurrentHeight() -> CGFloat {
		return currentHeight
	}

	func setCurrentHeight(_ height: CGFloat) -> Void {
		currentHeight = height
	}

	func getPositionX(_ positionX:CGFloat) ->  CGFloat {
		return (currentWidth * positionX) / defaultWidth
	}

	func getPositionY(_ positionY:CGFloat) ->  CGFloat {
		return (currentHeight * positionY) / defaultHeight
	}

	func getItemWidth(_ itemWidth:CGFloat) ->  CGFloat {
		return (currentWidth * itemWidth) / defaultWidth
	}

	func getItemHeight(_ itemHeight:CGFloat) ->  CGFloat {
		return (currentHeight * itemHeight) / defaultHeight
	}
}
