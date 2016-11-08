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

    var message = ""
    func GetMessage() -> String {
        return message
    }
    func SetMessage(_ value: String) {
        message = value
    }
}
