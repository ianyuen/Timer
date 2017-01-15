//
//  HistoryDetail.swift
//  Timer
//
//  Created by ian on 12/14/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class HistoryDetail: View {
	let objectManager = ObjectManager()

	private var title = UILabel()
	private var content = UILabel()

	private var titleText = ""
	private var contentText = ""

	override func initView() {
		objectManager.parent = self
		objectManager.Parse("HistoryDetail")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				AddLabel(object)
			default: break
			}
		}
	}

	func AddLabel(_ object: ScreenObject) {
		switch object.name {
		case "title":
			object.text = titleText
			objectManager.AddLabel(title, parent: self, object: object)
		case "content":
			object.text = contentText
			objectManager.AddLabel(content, parent: self, object: object)
		default: break
		}
	}

	func SetTitle(_ value: String) {
		titleText = value
	}

	func SetContent(_ value: String) {
		contentText = value
	}
}
