//
//  Settings.swift
//  Timer
//
//  Created by ian on 11/30/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Settings: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let objectManager = ObjectManager()
	let workoutName = ["Profile Name", "Insane Fat Blasting BootCamp", "Barbell Tabata Workout", "Barbell Tabata Workout", "Barbell Tabata Workout", "Barbell Tabata Workout"]

	let tableView = UITableView()
	let titleBack = UILabel()
	let background = UILabel()
	let newButton = NewButton()
	let editButton = NewButton()
	let backButton = BackButton()
	let weightButton = NewButton()

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)
		initView()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
    }

	override var prefersStatusBarHidden: Bool {
		return true
	}

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Settings")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "table":
				AddTableView(object)
			case "background":
				if object.name == "titleBack" {
					objectManager.AddBackground(titleBack, view: view, object: object)
				} else if object.name == "background" {
					objectManager.AddBackground(background, view: view, object: object)
				}
			case "newButton":
				if object.name == "newButton" {
					objectManager.AddNewButton(newButton, view: view, object: object)
				} else if object.name == "editButton" {
					objectManager.AddNewButton(editButton, view: view, object: object)
				} else if object.name == "weightButton" {
					objectManager.AddNewButton(weightButton, view: view, object: object)
				}
			case "backButton":
				objectManager.AddBackButton(backButton, view: view, object: object)
			default: break
			}
		}
	}

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showMain", sender: self)
	}

	func AddTableView(_ object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		tableView.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(WorkoutCell.self, forCellReuseIdentifier: "cell")
		tableView.layoutMargins = UIEdgeInsets.zero
		tableView.separatorInset = UIEdgeInsets.zero
		
		let color = Color()
		tableView.separatorColor = color.UIColorFromHex(object.color)
		tableView.backgroundColor = color.UIColorFromHex(object.color)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = ScreenSize.instance.GetItemHeight(128)
		self.view.addSubview(tableView)
	}

	func btnTableViewCellClicked(_ rowIndex: Int) {
	}

	//tableview delegate
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		btnTableViewCellClicked(indexPath.row)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workoutName.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:WorkoutCell! = tableView.dequeueReusableCell(withIdentifier: "cell") as! WorkoutCell!
		cell.name = workoutName[indexPath.row]
		cell.initView()
		return cell
	}
}
