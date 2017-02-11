//
//  ViewController.swift
//  TextBoxApp
//
//  Created by Wendy Wise on 8/20/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func changeLabelButtonClicked(_ sender: UIButton) {
        myLabel.text = myTxtField.text
    }
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

