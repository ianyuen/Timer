//
//  HistoryScroll.swift
//  Timer
//
//  Created by ian on 12/13/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class HistoryScroll: ScrollView {
	var controller = ViewController()
	let objectManager = ObjectManager()

	override func initView() {
		objectManager.parent = self
		let sessions = Database.instance.ReadSessions("sessions")
		if sessions.count > 0 {
			var index = sessions.count - 1
			let object = ScreenObject()
			let objectView = ScreenObject()
			objectView.width = 200
			objectView.height = 84
			objectView.clicked = #selector(btnViewClicked(_:))
			objectView.xPosition = 97 + 30
			objectView.yPosition = CGFloat(390 + 14 + 50)

			let objectDelete = ScreenObject()
			objectDelete.size = 20
			objectDelete.font = "LiberationSans"
			objectDelete.title = "Delete"
			objectDelete.clicked = #selector(btnDeleteClicked(_:))
			objectDelete.posXRaw = "parentWidth - width - 125"
			objectDelete.yPosition = 420

			while index >= 0 {
				let view = HistoryCell()
				let viewButton = ViewButton()
				let deleteButton = Button()

				view.parent = self

				let date = NSDate(timeIntervalSince1970: sessions[index].epoch)
				let dateFormatter = DateFormatter()

				dateFormatter.dateFormat = "MMM/dd/YYYY"
				view.SetDateContent(dateFormatter.string(from: date as Date))

				dateFormatter.dateFormat = "hh:mm a"
				view.SetTimeContent(dateFormatter.string(from: date as Date))

				view.SetTrainingContent(sessions[index].training)
				//objectManager.AddView(view, parent: self, object: object)

				viewButton.Index(index)
				objectManager.AddButton(viewButton, parent: self, object: objectView)
				objectManager.AddButton(deleteButton, parent: self, object: objectDelete)

				index = index - 1
				object.yPosition = object.yPosition + object.height + 50
				objectView.yPosition = objectView.yPosition + object.height + 50
				objectDelete.yPosition = objectView.yPosition
			}
		}

		var contentHeight: CGFloat = 0
		for view in subviews {
			let viewHeight = view.frame.origin.y + ScreenSize.instance.GetItemHeight(495)
			contentHeight = contentHeight > viewHeight ? contentHeight : viewHeight
		}
		contentSize = CGSize(width: frame.width, height: contentHeight)
	}

	func btnViewClicked(_ sender: ViewButton) {
		Application.instance.SessionIndex(sender.Index())
		controller.PerformSegue("showDetails")
	}

	func btnDeleteClicked(_ sender: ViewButton) {
		print("\(#function)")
	}
}
