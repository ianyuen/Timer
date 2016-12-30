//
//  View.swift
//  Timer
//
//  Created by ian on 12/13/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class View: UIView {
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		layoutIfNeeded()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func initView() {}
}
