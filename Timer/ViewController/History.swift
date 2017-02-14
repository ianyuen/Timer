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

	let content = HistoryScroll()
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

	override func viewDidAppear(_ animated: Bool) {
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
			case "backButton":
				DrawButton(object)
			case "scrollView":
				content.delegate = self
				content.controller = self
				objectManager.AddScrollView(content, view: view, object: object)
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
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
}
