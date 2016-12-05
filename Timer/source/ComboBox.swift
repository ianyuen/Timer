//
//  ComboBox.swift
//  Timer
//
//  Created by ian on 12/6/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ComboBox: UIView, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
	let objectManager = ObjectManager()

	private var text = ""
	private var width: CGFloat = 0
	private var height: CGFloat = 0
	private var fontName = ""
	private var fontSize: CGFloat = 0
	private var textColor: UInt32 = 0

	let textBox = UITextField()
	let dropDown = UIPickerView()

	var list = ["1", "2", "3"]

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		textBox.delegate = self
		dropDown.delegate = self
		dropDown.dataSource = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func initView() {
		objectManager.parent = self
		objectManager.Parse("ComboBox")
		for object in objectManager.GetObjects() {
			object.width = width
			object.height = height
			switch object.type {
			case "picker":
				objectManager.AddPicker(dropDown, view: self, object: object)
			case "textField":
				object.text = list[0]
				object.font = fontName
				object.size = fontSize
				objectManager.AddTextField(textBox, view: self, object: object)
			default: break
			}
		}
	}

	func SetText(_ value: String) {
		text = value
	}
	
	func SetFont(_ name: String, size: CGFloat) {
		fontName = name
		fontSize = size
	}
	
	func SetWidth(_ value: CGFloat) {
		width = value
	}
	
	func SetHeight(_ value: CGFloat) {
		height = value
	}
	
	func SetTextColor(_ value: UInt32) {
		textColor = value
	}

	//UIPickerViewDelegate
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return list[row]
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		textBox.text = list[row]
		dropDown.isHidden = true
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return list.count
	}

	//UITextFieldDelegate
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField == self.textBox {
			dropDown.isHidden = false
			textField.endEditing(true)
		}
	}
}
