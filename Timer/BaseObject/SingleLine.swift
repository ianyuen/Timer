//
//  SingleLine.swift
//  Timer
//
//  Created by ian on 12/14/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class SingleLine: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(rect: rect)
		let color = Color().UIColorFromHex(0xf9aa43)
		color.setFill()
		path.fill()
	}
}
