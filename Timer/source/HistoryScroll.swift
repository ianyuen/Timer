//
//  HistoryScroll.swift
//  Timer
//
//  Created by ian on 12/13/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class HistoryScroll: ScrollView {
	let objectManager = ObjectManager()

	let view1 = HistoryCell()
	let view2 = HistoryCell()
	let view3 = HistoryCell()
	let view4 = HistoryCell()

	override func initView() {
		layoutIfNeeded()

		objectManager.parent = self

		let object = ScreenObject()
		objectManager.AddView(view1, parent: self, object: object)

		object.yPosition = 495 + 50
		objectManager.AddView(view2, parent: self, object: object)

		object.yPosition = (CGFloat(495 + 50 + 495 + 50))
		objectManager.AddView(view3, parent: self, object: object)

		object.yPosition = (CGFloat(495 + 50 + 495 + 50 + 495 + 50))
		objectManager.AddView(view4, parent: self, object: object)

		var contentHeight: CGFloat = 0
		for view in subviews {
			let viewHeight = view.frame.origin.y + ScreenSize.instance.GetItemHeight(495)
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		contentSize = CGSize(width: frame.width, height: contentHeight)
	}
}
