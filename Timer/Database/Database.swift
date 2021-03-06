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

	func HaveData(_ key: String) -> Bool {
		if UserDefaults.standard.object(forKey: key) != nil {
			return true
		} else {
			return false
		}
	}

	func SaveInt(_ key: String, data: Int) {
		UserDefaults.standard.set(data, forKey: key)
	}
	
	func ReadInt(_ key: String) -> Int {
		if let data = UserDefaults.standard.object(forKey: key) as? Int {
			return data
		} else {
			return 0
		}
	}

    func SaveBool(_ key: String, data: Bool) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func ReadBool(_ key: String) -> Bool {
        if let data = UserDefaults.standard.object(forKey: key) as? Bool {
            return data
        } else {
            return false
        }
    }

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

	func SaveSessions(_ key: String, object: [Session]) {
		let data = NSKeyedArchiver.archivedData(withRootObject: object)
		UserDefaults.standard.set(data, forKey: key)
	}
	
	func ReadSessions(_ key: String) -> [Session] {
		if let data = UserDefaults.standard.data(forKey: key) {
			return NSKeyedUnarchiver.unarchiveObject(with: data ) as! [Session]
		} else {
			return [Session]()
		}
	}

	func SaveWorkouts(_ key: String, object: [Workout]) {
		let data = NSKeyedArchiver.archivedData(withRootObject: object)
		UserDefaults.standard.set(data, forKey: key)
	}

	func ReadWorkouts(_ key: String) -> [Workout] {
		if let data = UserDefaults.standard.data(forKey: key) {
			return NSKeyedUnarchiver.unarchiveObject(with: data ) as! [Workout]
		} else {
			return [Workout]()
		}
	}
}
