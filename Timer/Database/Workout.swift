//
//  Workout.swift
//  Timer
//
//  Created by Thanh Long on 1/6/17.
//  Copyright © 2017 ian. All rights reserved.
//

import Foundation

class Workout: NSObject, NSCoding {
	var name: String
	var rounds: Int
	var roundsName: [String]

	var rest: Int
	var warmUp: Int
	var coolDown: Int
	var roundTime: Int

	var sound: String
	var vibrate: Bool
	var routine: Bool

	func encode(with coder: NSCoder) {
		coder.encode(name, forKey: "name")
		coder.encode(rounds, forKey: "rounds")
		coder.encode(roundsName, forKey: "roundsName")

		coder.encode(rest, forKey: "red")
		coder.encode(warmUp, forKey: "warmUp")
		coder.encode(coolDown, forKey: "coolDown")
		coder.encode(roundTime, forKey: "roundTime")

		coder.encode(sound, forKey: "sound")
		coder.encode(vibrate, forKey: "vibrate")
		coder.encode(routine, forKey: "routine")
	}

	required init(coder decoder: NSCoder) {
		name = decoder.decodeObject(forKey: "name") as! String
		rounds = decoder.decodeInteger(forKey: "rounds")
		roundsName = decoder.decodeObject(forKey: "roundsName") as! [String]

		rest = decoder.decodeInteger(forKey: "red")
		warmUp = decoder.decodeInteger(forKey: "warmUp")
		coolDown = decoder.decodeInteger(forKey: "coolDown")
		roundTime = decoder.decodeInteger(forKey: "roundTime")
		
		sound = decoder.decodeObject(forKey: "sound") as! String
		vibrate = decoder.decodeBool(forKey: "vibrate")
		routine = decoder.decodeBool(forKey: "routine")
	}

	required init(name: String = "Workout", rounds: Int = 2, roundsName: [String] = [String](), red: Int = 10, warmUp: Int = 10, coolDown: Int = 10, roundTime: Int = 20, sound: String = "Alarm", vibrate: Bool = true, routine: Bool = false, motivation: Bool = true) {
		self.name = name
		self.rounds = rounds
		self.roundsName = roundsName

		self.rest = red
		self.warmUp = warmUp
		self.coolDown = coolDown
		self.roundTime = roundTime

		self.sound = sound
		self.vibrate = vibrate
		self.routine = routine
	}
}
