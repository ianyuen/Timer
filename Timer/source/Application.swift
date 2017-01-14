//
//  Application.swift
//  Timer
//
//  Created by ian on 11/8/16.
//  Copyright © 2016 ian. All rights reserved.
//

import Foundation

class Application {
    static let instance = Application()

	private var message = ""
	func GetMessage() -> String {
		return message
	}
	func SetMessage(_ value: String) {
		message = value
	}

	private var currentWorkout = ""
	func GetCurrentWorkout() -> String {
		return currentWorkout
	}
	func SetCurrentWorkout(_ value: String) {
		currentWorkout = value
	}

	enum WorkoutTask {
		case new
		case edit
	}
	private var workoutTask = WorkoutTask.new
	func GetWorkoutTask() -> WorkoutTask {
		return workoutTask
	}
	func SetWorkoutTask(_ task: WorkoutTask) {
		workoutTask = task
	}
}
