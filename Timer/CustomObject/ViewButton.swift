//
//  ViewButton.swift
//  Timer
//
//  Created by ian on 12/15/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ViewButton: Button {
	let objectManager = ObjectManager()

	let label = UILabel()
	let image = UIImageView()
	
	override func initView() {
		objectManager.parent = self
		objectManager.Parse("ViewButton")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "image":
				objectManager.AddImage(image, parent: self, object: object)
			case "label":
				objectManager.AddLabel(label, parent: self, object: object)
			default: break
			}
		}
	}
}
