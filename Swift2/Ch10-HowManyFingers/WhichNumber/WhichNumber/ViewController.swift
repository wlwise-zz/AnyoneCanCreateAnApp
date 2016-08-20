//
//  ViewController.swift
//  WhichNumber
//
//  Created by Wendy Wise on 4/6/15.
//  Copyright (c) 2015 WiseAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numFingers: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var numberGuessed = 3
    
    @IBAction func guessButton(sender: AnyObject) {
        let randomNumber = Int(arc4random_uniform(6))
        
        if numberGuessed == randomNumber{
            resultLabel.text = "Congrats!  I was holding \(numberGuessed) fingers up!"
        }else{
            resultLabel.text = "You guessed \(numberGuessed), but it was \(randomNumber)."
        }
    }
    @IBOutlet weak var stepperControl: UIStepper!
    @IBAction func stepperClicked(sender: AnyObject) {
        numberGuessed = Int(stepperControl.value)
        numFingers.text =  "\(numberGuessed)"
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

