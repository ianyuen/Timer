//
//  WorkoutCell.swift
//  Timer
//
//  Created by ian on 12/2/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
	let objectManager = ObjectManager()

	var name = ""
	let textView = UITextView()
	let background = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func initView() {
		objectManager.parent = contentView
		objectManager.Parse("WorkoutCell")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "background":
				objectManager.AddBackground(background, view: contentView, object: object)
			case "text":
				object.text = name
				objectManager.AddText(textView, view: contentView, object: object)
			default: break
			}
		}

		background.layer.masksToBounds = true
		background.layer.cornerRadius = 8
		let color = Color()
		contentView.backgroundColor = color.UIColorFromHex(0xf9aa43)
	}
}
