//
//  ViewController.swift
//  Timer
//
//  Created by ian on 12/26/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override var shouldAutorotate: Bool {
		return false
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return UIInterfaceOrientationMask.portrait
	}

	func PerformSegue(_ identifier: String) {
		performSegue(withIdentifier: identifier, sender: self)
	}
}
