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

	override func initView() {
		layoutIfNeeded()
		objectManager.parent = self

		var sessions = Database.instance.ReadSessions("sessions")
		if sessions.count == 0 {
			sessions.append(Session())
			Database.instance.SaveSessions("sessions", object: sessions)
		}

		var index = sessions.count - 1
		let object = ScreenObject()
		while index >= 0 {
			let view = HistoryCell()
			view.parent = self

			let date = NSDate(timeIntervalSince1970: sessions[index].epoch)
			let dateFormatter = DateFormatter()

			dateFormatter.dateFormat = "MMM/dd/YYYY"
			view.SetDateContent(dateFormatter.string(from: date as Date))

			dateFormatter.dateFormat = "hh:mm a"
			view.SetTimeContent(dateFormatter.string(from: date as Date))

			view.SetTrainingContent(sessions[index].training)
			objectManager.AddView(view, parent: self, object: object)
			index = index - 1
			object.yPosition = object.yPosition + object.height + 50
		}

		var contentHeight: CGFloat = 0
		for view in subviews {
			let viewHeight = view.frame.origin.y + ScreenSize.instance.GetItemHeight(495)
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		contentSize = CGSize(width: frame.width, height: contentHeight)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		testTouches(touches)
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		testTouches(touches)
	}

	func testTouches(_ touches: Set<UITouch>) {
		// Get the first touch and its location in this view controller's view coordinate system
		let touch = touches.first! as UITouch
		let touchLocation = touch.location(in: self)
		
		for subview in subviews {
			// Convert the location of the obstacle view to this view controller's view coordinate system
			let subviewFrame = self.convert(subview.frame, from: subview.superview)
			
			// Check if the touch is inside the obstacle view
			if subviewFrame.contains(touchLocation) {
				print("Game over!")
			}
		}
	}

	func btnViewClicked(_ sender: Button) {
	}
}
