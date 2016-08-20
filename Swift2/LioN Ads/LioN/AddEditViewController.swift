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
    func addItemViewController(controller: AddEditViewController, didFinishEditingItem lionItem: Lion)
}

class AddEditViewController: UITableViewController, UITextFieldDelegate{
    weak var delegate: AddEditViewControllerDelegate?
    var newLion: Lion?
    var likeVar: Int = 1  //1 is like, and 0 is dislike
    var lionToEdit : Lion?
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var lionNotes: UITextView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        nameTxt.becomeFirstResponder()
        doneButton.enabled = false
        let borderColor : UIColor = UIColor.brownColor()
        lionNotes.layer.borderWidth = 0.5
        lionNotes.layer.borderColor = borderColor.CGColor
        lionNotes.layer.cornerRadius = 5.0
        
        if let item = lionToEdit{
            title = "Edit LioN"
            descTxt.text = item.lionDescription
            nameTxt.text = item.lionName
            likeVar = item.like
            lionNotes.text = item.lionNotes
            doneButton.enabled = true
        }else{
            title = "Add LioN"
        }
        toggleLike()
    }
    
    func toggleLike(){
        //1 is like, and 0 is dislike
        if likeVar == 1 {
            likeButton.setImage(UIImage(imageLiteral: "likeItSelected"), forState: .Normal)
            dislikeButton.setImage(UIImage(imageLiteral: "orNot"), forState: .Normal)
        }else{
            likeButton.setImage(UIImage(imageLiteral: "likeIt"), forState: .Normal)
            dislikeButton.setImage(UIImage(imageLiteral: "orNotSelected"), forState: .Normal)
        }
    }
    
    @IBAction func likeClicked(sender: AnyObject) {
        likeVar = 1
        toggleLike()
        dismissKeyboard()
    }
    
    @IBAction func dislikeClicked(sender: AnyObject) {
        likeVar = 0
        toggleLike()
        dismissKeyboard()
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func doneClicked(){
        if let item = lionToEdit{
            item.like = likeVar
            item.lionDescription = descTxt.text!
            item.lionName = nameTxt.text!
            item.lionNotes = lionNotes.text!
            delegate?.addItemViewController(self, didFinishEditingItem: item)
        }else{
            newLion = Lion()
            newLion?.lionName = nameTxt.text!
            newLion?.lionDescription = descTxt.text!
            newLion?.like = likeVar
            newLion?.lionNotes = lionNotes.text!
            delegate?.addItemViewController(self, didFinishAddingItem: newLion!)
        }
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
