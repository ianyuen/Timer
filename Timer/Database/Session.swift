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
	var rounds: Int
	var restTime: Int
	var training: String
	var roundTime: Int
	var warmUpTime: Int
	var totalRounds: Int
	var coolDownTime: Int
	var totalTrainingTime: Int

	func encode(with coder: NSCoder) {
		coder.encode(epoch, forKey: "epoch")
		coder.encode(rounds, forKey: "rounds")
		coder.encode(restTime, forKey: "restTime")
		coder.encode(training, forKey: "training")
		coder.encode(roundTime, forKey: "roundTime")
		coder.encode(warmUpTime, forKey: "warmUpTime")
		coder.encode(totalRounds, forKey: "totalRounds")
		coder.encode(coolDownTime, forKey: "coolDownTime")
		coder.encode(totalTrainingTime, forKey: "totalTrainingTime")
	}

	required init(coder decoder: NSCoder) {
		epoch = decoder.decodeDouble(forKey: "epoch")
		rounds = decoder.decodeInteger(forKey: "rounds")
		restTime = decoder.decodeInteger(forKey: "restTime")
		training = decoder.decodeObject(forKey: "training") as! String
		roundTime = decoder.decodeInteger(forKey: "roundTime")
		warmUpTime = decoder.decodeInteger(forKey: "warmUpTime")
		totalRounds = decoder.decodeInteger(forKey: "totalRounds")
		coolDownTime = decoder.decodeInteger(forKey: "coolDownTime")
		totalTrainingTime = decoder.decodeInteger(forKey: "totalTrainingTime")

	}

	required init(training: String = "Workout", epoch: Double = 1484449200, totalRounds: Int = 7, rounds: Int = 7, roundTime: Int = 20, restTime: Int = 20, warmUpTime: Int = 20, coolDownTime: Int = 20, totalTrainingTime: Int = 70) {
		self.epoch = epoch
		self.training = training

		self.rounds = rounds
		self.restTime = restTime
		self.roundTime = roundTime
		self.warmUpTime = warmUpTime
		self.totalRounds = totalRounds
		self.coolDownTime = coolDownTime
		self.totalTrainingTime = totalTrainingTime
	}
}
