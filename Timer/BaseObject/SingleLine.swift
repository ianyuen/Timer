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
		let aPath = UIBezierPath()
		aPath.move(to: CGPoint(x: 0, y: 100))
		aPath.addLine(to: CGPoint(x: 100, y: 100))
		aPath.close()
		
		UIColor.blue.set()
		aPath.stroke()
		aPath.fill()
	}
}
