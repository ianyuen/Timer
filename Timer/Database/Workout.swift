//
//  Workout.swift
//  Timer
//
//  Created by Thanh Long on 1/6/17.
//  Copyright © 2017 ian. All rights reserved.
//

import Foundation

class Workout: NSObject, NSCoding {
	let name: String = "Workout"
	let rounds = 2

	var red: Int32 = 30
	var warmUp: Int32 = 30
	var coolDown: Int32 = 30
	var roundTime: Int32 = 30

	let sound = "Digital"
	let vibrate = true
	let routine = true
	let motivation = true

	required init?(coder aDecoder: NSCoder) {}
	func encode(with aCoder: NSCoder) {}
}
