//
//  AddEditViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/24/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

protocol AddEditViewControllerDelegate : class {
    func addItemViewControllerDidCancel(controller: AddEditViewController)
    func addItemViewController(controller: AddEditViewController, didFinishAddingItem lionItem: Lion)
    func addItemViewController(controller: AddEditViewController, didFinishEditingItem lionItem: Lion)
}

class AddEditViewController : UITableViewController, UITextFieldDelegate {
    weak var delegate: AddEditViewControllerDelegate?
    var newLion : Lion?
    var likeVar : Int = 1 //like is 1 and dislike is 0
    var lionToEdit : Lion?

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBAction func likeClicked(_ sender: AnyObject) {
        likeVar = 1
        toggleLike()
    }
    
    @IBAction func dislikeClicked(_ sender: AnyObject) {
        likeVar = 0
        toggleLike()
    }
    
    func toggleLike(){
        if likeVar == 1 {
            dislikeButton.backgroundColor = UIColor.clear
            likeButton.backgroundColor = UIColor.green
        }else {
            dislikeButton.backgroundColor = UIColor.red
            likeButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func doneClicked(){
        if let item = lionToEdit{
            item.like = likeVar
            item.lionDescription = descTxt.text!
            item.lionName = nameTxt.text!
            delegate?.addItemViewController(controller: self, didFinishEditingItem: item)
        }else {
            newLion = Lion()
            newLion?.lionName = nameTxt.text!
            newLion?.lionDescription = descTxt.text!
            newLion?.like = likeVar
            delegate?.addItemViewController(controller: self, didFinishAddingItem: newLion!)
        }
    }
    
    @IBAction func cancelClicked(){
        delegate?.addItemViewControllerDidCancel(controller: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText : NSString = textField.text! as NSString
        let newText : NSString = oldText.replacingCharacters(in: range, with: string) as NSString
        doneButton.isEnabled = (newText.length > 0)
        return true
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == nameTxt){
            nameTxt.resignFirstResponder()
            descTxt.becomeFirstResponder()
        }else {
            descTxt.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        if let item = lionToEdit {
            title = "Edit Lion"
            descTxt.text = item.lionDescription
            nameTxt.text = item.lionName
            likeVar = item.like
            doneButton.isEnabled = true
        } else {
            title = "Add Lion"
            likeButton.backgroundColor = UIColor.green
        }
        toggleLike()
        nameTxt.becomeFirstResponder()
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
