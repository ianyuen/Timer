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

	var background = UIImageView()

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
		objectManager.DrawObject(background, type: "image", name: "background")

		let color = Color()
		contentView.backgroundColor = color.UIColorFromHex(0xf9aa43)
	}
}
