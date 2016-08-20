//
//  DetailViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/13/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var lionDetail : Lion?
    
    override func viewDidLoad() {
        print(lionDetail?.lionName)
        lblName.text = lionDetail?.lionName
        lblDesc.text = lionDetail?.lionDescription
        lblLike.text = lionDetail?.like.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
