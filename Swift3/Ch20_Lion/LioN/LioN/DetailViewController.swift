//
//  DetailViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/24/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    var lionDetail : Lion?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = lionDetail?.lionName
        lblDesc.text = lionDetail?.lionDescription
        lblLike.text = lionDetail?.like.description
    }
}
