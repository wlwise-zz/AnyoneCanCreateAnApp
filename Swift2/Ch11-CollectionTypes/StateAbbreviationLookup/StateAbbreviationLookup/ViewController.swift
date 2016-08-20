//
//  ViewController.swift
//  StateAbbreviationLookup
//
//  Created by Wendy Wise on 6/6/15.
//  Copyright (c) 2015 WiseAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var stateDict = ["Georgia" : "GA", "Washington" : "WA", "North Carolina" : "NC", "Oregon" : "OR", "Indiana" : "IN"]
    
    
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func lookupClicked(sender: AnyObject) {
        let dictionaryKey = stateTextField.text
        if dictionaryKey == ""{
            resultLabel.text = "Please enter a state name"
        }else{
            if let stateAbb = stateDict[dictionaryKey!]{
                resultLabel.text = stateAbb
            }else{
                 resultLabel.text = "No state abbreviation found"
            }
         }
         resultLabel.hidden = false
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

