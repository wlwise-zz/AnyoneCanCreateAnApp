//
//  ViewController.swift
//  LifeCycle2
//
//  Created by Wendy Wise on 8/23/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var counter = 0
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter++
        print(counter)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("view will appear")
        counter++
        print(counter)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        print("view did disappear")
    }


}

