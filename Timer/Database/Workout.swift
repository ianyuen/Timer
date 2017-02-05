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

	var rest: Int
	var warmUp: Int
	var coolDown: Int
	var roundTime: Int

	var sound: String
	var vibrate: Bool
	var routine: Bool
	var motivation: Bool

	func encode(with coder: NSCoder) {
		coder.encode(name, forKey: "name")
		coder.encode(rounds, forKey: "rounds")

		coder.encode(rest, forKey: "red")
		coder.encode(warmUp, forKey: "warmUp")
		coder.encode(coolDown, forKey: "coolDown")
		coder.encode(roundTime, forKey: "roundTime")

		coder.encode(sound, forKey: "sound")
		coder.encode(vibrate, forKey: "vibrate")
		coder.encode(routine, forKey: "routine")
		coder.encode(motivation, forKey: "motivation")
	}

	required init(coder decoder: NSCoder) {
		name = decoder.decodeObject(forKey: "name") as! String
		rounds = decoder.decodeInteger(forKey: "rounds")

		rest = decoder.decodeInteger(forKey: "red")
		warmUp = decoder.decodeInteger(forKey: "warmUp")
		coolDown = decoder.decodeInteger(forKey: "coolDown")
		roundTime = decoder.decodeInteger(forKey: "roundTime")
		
		sound = decoder.decodeObject(forKey: "sound") as! String
		vibrate = decoder.decodeBool(forKey: "vibrate")
		routine = decoder.decodeBool(forKey: "routine")
		motivation = decoder.decodeBool(forKey: "motivation")
	}

	required init(name: String = "Workout", rounds: Int = 2, red: Int = 10, warmUp: Int = 10, coolDown: Int = 10, roundTime: Int = 20, sound: String = "Digital", vibrate: Bool = true, routine: Bool = true, motivation: Bool = true) {
		self.name = name
		self.rounds = rounds

		self.rest = red
		self.warmUp = warmUp
		self.coolDown = coolDown
		self.roundTime = roundTime

		self.sound = sound
		self.vibrate = vibrate
		self.routine = routine
		self.motivation = motivation
	}
}
