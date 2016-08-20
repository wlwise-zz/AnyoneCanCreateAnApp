//
//  DetailViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/13/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    var lionDetail : Lion?
    
    override func viewDidLoad() {
        print(lionDetail?.lionName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
