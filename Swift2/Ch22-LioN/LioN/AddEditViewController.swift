//
//  AddEditViewController.swift
//  LioN
//
//  Created by Wendy Wise on 10/10/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit

class AddEditViewController: UITableViewController, UITextFieldDelegate{
    
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        nameTxt.becomeFirstResponder()
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func doneClicked(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelClicked(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameTxt{
            nameTxt.resignFirstResponder()
            descTxt.becomeFirstResponder()
        }else{
            descTxt.resignFirstResponder()
        }
        return true
    }
}
