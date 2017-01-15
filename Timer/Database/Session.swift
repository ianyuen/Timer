//
//  Session.swift
//  Timer
//
//  Created by ian on 12/13/16.
//  Copyright © 2016 ian. All rights reserved.
//

import Foundation

class Session: NSObject, NSCoding {
	var epoch: Double
	var training: String

	func encode(with coder: NSCoder) {
		coder.encode(epoch, forKey: "epoch")
		coder.encode(training, forKey: "training")
	}

	required init(coder decoder: NSCoder) {
		epoch = decoder.decodeDouble(forKey: "epoch")
		training = decoder.decodeObject(forKey: "training") as! String
	}

	required init(training: String = "Workout", epoch: Double = 1484449200) {
		self.epoch = epoch
		self.training = training
	}
}
