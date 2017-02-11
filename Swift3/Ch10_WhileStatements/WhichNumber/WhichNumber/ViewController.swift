//
//  ViewController.swift
//  WhichNumber
//
//  Created by Wendy Wise on 8/21/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberGuessed = 3
    
    @IBOutlet weak var numFingers: UILabel!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var resultLabel: UILabel!
  
    @IBAction func guessButtonClick(_ sender: UIButton) {
        let randomNumber = Int(arc4random_uniform(6))
        if numberGuessed == randomNumber {
            resultLabel.text = "Congrats!  I was holding \(numberGuessed) fingers up!"
        } else {
            resultLabel.text = "You guessed \(numberGuessed), but it was \(randomNumber)."
        }
    }
    
    @IBAction func stepperClick(_ sender: UIStepper) {
        numberGuessed = Int(stepperControl.value)
        numFingers.text = "\(numberGuessed)"
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

