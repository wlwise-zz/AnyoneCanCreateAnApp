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
}

class AddEditViewController : UITableViewController, UITextFieldDelegate {
    weak var delegate: AddEditViewControllerDelegate?
    var newLion : Lion?
    var likeVar : Int = 1

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBAction func likeClicked(_ sender: AnyObject) {
        likeVar = 1
    }
    
    @IBAction func dislikeClicked(_ sender: AnyObject) {
        likeVar = 0
    }
    
    @IBAction func doneClicked(){
        newLion = Lion()
        newLion?.lionName = nameTxt.text!
        newLion?.lionDescription = descTxt.text!
        newLion?.like = likeVar
        delegate?.addItemViewController(controller: self, didFinishAddingItem: newLion!)
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
