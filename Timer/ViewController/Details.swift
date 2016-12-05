//
//  Details.swift
//  Timer
//
//  Created by ian on 12/3/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class Details: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let objectManager = ObjectManager()

	let tableView = UITableView()
	let titleBack = UILabel()
	let titleText = UILabel()
	let background = UILabel()
	let backButton = BackButton()

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

	override var prefersStatusBarHidden: Bool {
		return true
	}

	func initView() {
		objectManager.parent = view
		objectManager.controller = self
		objectManager.Parse("Details")
		for object in objectManager.GetObjects() {
			switch object.type {
			case "table":
				AddTableView(object)
			case "label":
				DrawLabel(object)
			case "background":
				DrawBackground(object)
			case "backButton":
				objectManager.AddBackButton(backButton, view: view, object: object)
			default: break
			}
		}
	}

	func DrawLabel(_ object: ScreenObject) {
		switch object.name {
		case "titleText":
			objectManager.AddLabel(titleText, view: view, object: object)
		default: break
		}
	}

	func DrawBackground(_ object: ScreenObject) {
		switch object.name {
		case "titleBack":
			objectManager.AddBackground(titleBack, view: view, object: object)
		case "background":
			objectManager.AddBackground(background, view: view, object: object)
		default: break
		}
	}

	func btnBackClicked(_ sender:UIButton!) {
		self.performSegue(withIdentifier: "showSettings", sender: self)
	}

	func AddTableView(_ object: ScreenObject) {
		let positionX = ScreenSize.instance.GetPositionX(object.xPosition)
		let positionY = ScreenSize.instance.GetPositionY(object.yPosition)
		let itemWidth = ScreenSize.instance.GetItemWidth(object.width)
		let itemHeight = ScreenSize.instance.GetItemHeight(object.height)
		
		tableView.frame = CGRect(x: positionX, y: positionY, width: itemWidth, height: itemHeight)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(DetailsCell.self, forCellReuseIdentifier: "cell")
		tableView.layoutMargins = UIEdgeInsets.zero
		tableView.separatorInset = UIEdgeInsets.zero
		
		let color = Color()
		tableView.separatorColor = color.UIColorFromHex(object.color)
		tableView.backgroundColor = color.UIColorFromHex(object.color)
		tableView.rowHeight = ScreenSize.instance.GetItemHeight(1704)
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
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:DetailsCell! = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetailsCell!
		cell.backgroundColor = tableView.backgroundColor
		cell.initView()
		return cell
	}
}
