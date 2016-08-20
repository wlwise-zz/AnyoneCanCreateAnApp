//
//  ViewController.swift
//  AirPortNameLookup
//
//  Created by Wendy Wise on 5/10/15.
//  Copyright (c) 2015 WiseAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var airportDictionary = ["ATL" : "Atlanta International", "PDK" : "Peachtree Dekalb", "AHN" : "Athens Regional", "AGS" : "Augusta Regaional", "SAV": "Savannah International"]

    @IBOutlet weak var codeTextField: UITextField!
  
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func lookupClicked(sender: AnyObject) {
        let dictionaryKey = codeTextField.text
        if dictionaryKey == ""{
            resultLabel.text = "Please enter a code"
        }else{
            if let airportName = airportDictionary[dictionaryKey!]{
                resultLabel.text = airportName
            }else{
                resultLabel.text = "No airport name found for \(dictionaryKey)"
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

