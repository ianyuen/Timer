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

	override func initView() {
		objectManager.parent = self

		let object = ScreenObject()
		objectManager.AddView(view1, parent: self, object: object)

		object.yPosition = 495 + 50
		objectManager.AddView(view2, parent: self, object: object)

		object.yPosition = (CGFloat(495 + 50 + 495 + 50))
		objectManager.AddView(view3, parent: self, object: object)

		contentSize = CGSize(width: frame.width, height: 2500)
	}
}
