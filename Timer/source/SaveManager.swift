//
//  SaveManager.swift
//  Timer
//
//  Created by Thanh Long on 1/6/17.
//  Copyright © 2017 ian. All rights reserved.
//

import Foundation

class SaveManager {
	static let instance = SaveManager()

	func HaveObject(_ key: String) -> Bool {
		let defaults = Foundation.UserDefaults.standard
		if defaults.object(forKey: key) != nil {
			return true
		} else {
			return false
		}
	}

	func SaveWorkouts(_ key: String, object: [Workout]) {
		let data = NSKeyedArchiver.archivedData(withRootObject: object)
		let defaults = UserDefaults.standard
		defaults.set(data, forKey: key)
	}

	func ReadWorkouts(_ key: String) -> [Workout] {
		var object = [Workout]()
		if let data = UserDefaults.standard.object(forKey: key) as? NSData {
			object = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Workout]
		}
		return object
	}
}
