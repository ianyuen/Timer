//
//  ViewController.swift
//  Timer
//
//  Created by ian on 11/7/16.
//  Copyright © 2016 ian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let width = self.view.frame.size.width
        let label = UILabel()
        label.text = Application.instance.GetMessage()
        label.frame = CGRect(x: 0, y: 20, width: 0, height: 0)
        label.sizeToFit()
        label.frame.origin.x = (width - label.frame.width) / 2
        view.addSubview(label)

        let button = UIButton()
        button.frame = CGRect(x: 0, y: 50, width: 50, height: 30)
        button.frame.origin.x = (width - button.frame.width) / 2
        button.setTitle("send", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.addTarget(self, action: #selector(btnSendClicked(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func btnSendClicked(_ sender:UIButton!) {
        let URLEncodedText = "test"
        let ourPath = "workouts://" + URLEncodedText
        let ourURL = NSURL(string: ourPath)
        let ourApplication = UIApplication.shared
        if ourApplication.canOpenURL(ourURL as! URL) {
            ourApplication.open(ourURL as! URL, options: [:], completionHandler: nil)

        }
    }
}
