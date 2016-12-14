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

	let view = HistoryCell()

	override func initView() {
		objectManager.parent = self

		let object = ScreenObject()
		objectManager.AddView(view, parent: self, object: object)
	}
}
