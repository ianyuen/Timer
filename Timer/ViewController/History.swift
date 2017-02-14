//
//  History.swift
//  Timer
//
//  Created by ian on 12/12/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class History: ViewController, UITableViewDelegate, UITableViewDataSource {
	let objectManager = ObjectManager()

	var sessions = Database.instance.ReadSessions("sessions")
	var tableView = UITableView()
	let titleText = UILabel()
	let backButton = BackButton()
	let background = UILabel()
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
	}

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showMain", sender: self)
	}

	func btnViewClicked(_ sender: Button!) {
		self.performSegue(withIdentifier: "showDetails", sender: self)
	}

	func initView() {
		objectManager.parent = view
		objectManager.Parse("History")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "label":
				objectManager.AddLabel(titleText, parent: view, object: object)
			case "table":
				AddTableView(object)
			case "backButton":
				DrawButton(object)
			case "background":
				DrawBackground(object)
			case "newButton":
				weightButton.SetText(object.text)
				weightButton.SetWidth(object.width)
				weightButton.SetHeight(object.height)
				objectManager.AddButton(weightButton, parent: view, object: object)
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
		tableView.register(HistoryCell.self, forCellReuseIdentifier: "cell")
		tableView.layoutMargins = UIEdgeInsets.zero
		tableView.separatorInset = UIEdgeInsets.zero
		tableView.tableFooterView = UIView()
		let color = Color()
		//textColor = color.UIColorFromHex(object.textColor)
		tableView.separatorColor = color.UIColorFromHex(object.lineColor)
		tableView.backgroundColor = color.UIColorFromHex(object.backColor)
		
		tableView.rowHeight = ScreenSize.instance.GetItemHeight(object.rowHeight)
		self.view.addSubview(tableView)
	}

	func DrawButton(_ object: ScreenObject) {
		switch object.name {
		case "backButton":
			objectManager.AddButton(backButton, parent: view, object: object, target: self)
		default: break
		}
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "background":
			objectManager.AddBackground(background, parent: view, object: object)
		default: break
		}
	}

	//tableview delegate
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sessions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! HistoryCell

		let date = NSDate(timeIntervalSince1970: sessions[indexPath.row].epoch)
		let dateFormatter = DateFormatter()
		
		dateFormatter.dateFormat = "MMM/dd/YYYY"
		cell.SetDateContent(dateFormatter.string(from: date as Date))
		
		dateFormatter.dateFormat = "hh:mm a"
		cell.SetTimeContent(dateFormatter.string(from: date as Date))
		cell.SetTrainingContent(sessions[indexPath.row].training)

		cell.initView()
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		Application.instance.SessionIndex(indexPath.row)
		PerformSegue("showDetails")
	}
}
