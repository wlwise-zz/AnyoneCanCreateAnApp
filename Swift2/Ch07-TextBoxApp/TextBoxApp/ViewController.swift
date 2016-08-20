//
//  ViewController.swift
//  TextBoxApp
//
//  Created by Wendy Wise on 3/15/15.
//  Copyright (c) 2015 WiseAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mytxtField: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    @IBAction func changeLabelClicked(sender: AnyObject) {
        myLabel.text = mytxtField.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

