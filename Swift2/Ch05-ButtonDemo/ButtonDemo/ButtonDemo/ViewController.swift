//
//  ViewController.swift
//  ButtonDemo
//
//  Created by Wendy Wise on 12/5/15.
//  Copyright © 2015 WisaAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 

    @IBOutlet weak var myLabel: UILabel!

    
    
    @IBAction func buttonClick(sender: AnyObject) {
        myLabel.text = "I dit it!"
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

