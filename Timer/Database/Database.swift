//
//  SaveManager.swift
//  Timer
//
//  Created by Thanh Long on 1/6/17.
//  Copyright © 2017 ian. All rights reserved.
//

import Foundation

class Database {
	static let instance = Database()

	func SaveString(_ key: String, data: String) {
		UserDefaults.standard.set(data, forKey: key)
	}

	func ReadString(_ key: String) -> String {
		if let data = UserDefaults.standard.object(forKey: key) as? String {
			return data
		} else {
			return ""
		}
	}

	func SaveWorkouts(_ key: String, object: [Workout]) {
		let data = NSKeyedArchiver.archivedData(withRootObject: object)
		UserDefaults.standard.set(data, forKey: key)
	}

	func ReadWorkouts(_ key: String) -> [Workout] {
		if let data = UserDefaults.standard.object(forKey: key) as? NSData {
			return NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Workout]
		} else {
			return [Workout]()
		}
	}
}
