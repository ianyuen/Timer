//
//  ScrollView.swift
//  Timer
//
//  Created by ian on 12/9/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ScrollView: UIScrollView {
	func initView() {}

	func DismissKeyboard() {
		endEditing(true)
	}

	func fitContentHeight() -> CGFloat {
		var contentHeight: CGFloat = 0
		for view in subviews {
			let viewHeight = view.frame.origin.y + view.frame.size.height
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		return contentHeight
	}
}
