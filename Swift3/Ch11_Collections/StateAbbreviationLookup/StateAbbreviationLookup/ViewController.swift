//
//  ViewController.swift
//  StateAbbreviationLookup
//
//  Created by Wendy Wise on 8/21/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stateTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var stateDict = ["Georgia" : "GA", "Washington" : "WA", "North Carolina" : "NC", "Oregon" : "OR", "Indiana" : "IN"]

    @IBAction func lookupClick(_ sender: AnyObject) {
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
        resultLabel.isHidden = false
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

