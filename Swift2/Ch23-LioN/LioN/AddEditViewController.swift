//
//  AddEditViewController.swift
//  LioN
//
//  Created by Wendy Wise on 10/10/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit

protocol AddEditViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller: AddEditViewController)
    func addItemViewController(controller: AddEditViewController, didFinishAddingItem lionItem: Lion)
}

class AddEditViewController: UITableViewController, UITextFieldDelegate{
    weak var delegate: AddEditViewControllerDelegate?
    var newLion: Lion?
    var likeVar: Int = 1
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        nameTxt.becomeFirstResponder()
        doneButton.enabled = false
    }
    @IBAction func likeClicked(sender: AnyObject) {
        likeVar = 1
    }
    
    @IBAction func dislikeClicked(sender: AnyObject) {
        likeVar = 0
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func doneClicked(){
        newLion = Lion()
        newLion?.lionName = nameTxt.text!
        newLion?.lionDescription = descTxt.text!
        newLion?.like = likeVar
        delegate?.addItemViewController(self, didFinishAddingItem: newLion!)
    }
    
    @IBAction func cancelClicked(){
        delegate?.addItemViewControllerDidCancel(self)
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText : NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneButton.enabled = (newText.length > 0)
        return true
    }
}
