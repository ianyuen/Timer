//
//  Settings.swift
//  Timer
//
//  Created by ian on 11/30/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Settings: ViewController, UITableViewDelegate, UITableViewDataSource {
	var textColor = UIColor()
	var workouts = [Workout]()
	var objectManager = ObjectManager()

	let backButton = BackButton()
	var tableView = UITableView()
	let titleBack = UILabel()
	let titleText = UILabel()
	let background = UILabel()

	let newButton = NewButton()
	let editButton = NewButton()
	let weightButton = NewButton()

	override func viewDidLoad() {
		super.viewDidLoad()

		ScreenSize.instance.SetStatusHeight(UIApplication.shared.statusBarFrame.size.height)
		ScreenSize.instance.SetCurrentWidth(self.view.frame.size.width)
		ScreenSize.instance.SetCurrentHeight(self.view.frame.size.height)

		workouts = Database.instance.ReadWorkouts("workouts")
		if workouts.count == 0 {
			workouts.append(Workout())
			Database.instance.SaveWorkouts("workouts", object: workouts)
		}

		initView()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
    }

	func initView() {
		objectManager.parent = view
		objectManager.Parse("Settings")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				objectManager.AddLabel(titleText, parent: view, object: object)
			case "table":
				AddTableView(object)
			case "background":
				DrawBackground(object)
			case "newButton":
				if object.name == "newButton" {
					DrawNewButton(newButton, object: object)
				} else if object.name == "editButton" {
					DrawNewButton(editButton, object: object)
				} else if object.name == "weightButton" {
					DrawNewButton(weightButton, object: object)
				}
			case "backButton":
				objectManager.AddButton(backButton, parent: view, object: object, target: self)
			default: break
			}
		}
	}

	func AddTableView(_ object: ScreenObject) {
		let x = ScreenSize.instance.GetPositionX(object.xPosition)
		let y = ScreenSize.instance.GetPositionY(object.yPosition)
		let width = ScreenSize.instance.GetItemWidth(object.width)
		let height = ScreenSize.instance.GetItemHeight(object.height)

		tableView.frame = CGRect(x: x, y: y, width: width, height: height)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.layoutMargins = UIEdgeInsets.zero
		tableView.separatorInset = UIEdgeInsets.zero
		tableView.tableFooterView = UIView()
		tableView.tableHeaderView = StandardTableHeaderView()
		let color = Color()
		textColor = color.UIColorFromHex(object.textColor)
		tableView.separatorColor = color.UIColorFromHex(object.lineColor)
		tableView.backgroundColor = color.UIColorFromHex(object.backColor)

		tableView.rowHeight = ScreenSize.instance.GetItemHeight(object.rowHeight)
		self.view.addSubview(tableView)
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "titleBack":
			objectManager.AddBackground(titleBack, parent: view, object: object)
		case "background":
			objectManager.AddBackground(background, parent: view, object: object)
		default: break
		}
	}

	func DrawNewButton(_ button: NewButton, object: ScreenObject) {
		button.SetText(object.text)
		button.SetWidth(object.width)
		button.SetHeight(object.height)
		objectManager.AddButton(button, parent: view, object: object, target: self)
	}

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showMain", sender: self)
	}

	func btnNewClicked(_ sender:UIButton!) {
		Application.instance.SetWorkoutTask(Application.WorkoutTask.new)
		self.performSegue(withIdentifier: "showDetails", sender: self)
	}

	func btnEditClicked(_ sender:UIButton!) {
		Application.instance.SetWorkoutTask(Application.WorkoutTask.edit)
		self.performSegue(withIdentifier: "showDetails", sender: self)
	}

	func btnWeightClicked(_ sender:UIButton!) {
		//self.performSegue(withIdentifier: "showDetails", sender: self)
	}

	func StandardTableHeaderView() -> UIView {
		let label = UILabel()
		let width = view.frame.width
		let height = 1 / UIScreen().scale
		label.frame = CGRect(x: 0, y: 0 , width: width, height: height)
		label.backgroundColor = Color().UIColorFromHex(0x64C9FC)

		let header = UIView()
		header.addSubview(label)
		return header
	}

	//tableview delegate
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workouts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
		cell.textLabel?.text = workouts[indexPath.row].name
		cell.textLabel?.textColor = textColor
		let fontName = cell.textLabel?.font.fontName
		let font = UIFont(name: fontName!, size: 20)
		cell.textLabel?.font = font
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		Application.instance.WorkoutIndex(indexPath.row)
		Database.instance.SaveInt("workoutIndex", data: indexPath.row)
	}
}
