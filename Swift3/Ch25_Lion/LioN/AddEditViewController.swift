//
//  AddEditViewController.swift
//  LioN
//
//  Created by Wendy Wise on 10/1/16.
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

    var lionDetail : Lion?
    var lionToEdit : Lion?

    var newLion: Lion?
    var likeVar: Int = 1 //1 is like, and 0 is dislike

    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var dislikeButton: UIButton!

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var descTxt: UITextField!
    
    @IBAction func likeClicked(_ sender: AnyObject) {
        likeVar = 1
        toggleLike()
    }
    @IBAction func dislikeClicked(_ sender: AnyObject) {
        likeVar = 0
        toggleLike()
    }

    
    
    @IBAction func doneClicked(){
        if let item = lionToEdit{
            item.like = likeVar
            item.lionDescription = descTxt.text!
            item.lionName = nameTxt.text!
            delegate?.addItemViewController(controller: self, didFinishEditingItem: item)

        }else{
            newLion = Lion()
            newLion?.lionName = nameTxt.text!
            newLion?.lionDescription = descTxt.text!
            newLion?.like = likeVar
            delegate?.addItemViewController(controller: self, didFinishAddingItem: newLion!)
        }


    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText : NSString = textField.text! as NSString
        let newText : NSString = oldText.replacingCharacters(in: range, with: string) as NSString
        doneButton.isEnabled = (newText.length > 0)
        return true
    }

    
    @IBAction func cancelClicked(){
        delegate?.addItemViewControllerDidCancel(controller: self)

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

    func dismissKeyboard(){
        view.endEditing(true)
    } 

    func toggleLike(){
        if likeVar == 1 {
            dislikeButton.setImage(UIImage(named: "orNot"), for: .normal)
            likeButton.setImage(UIImage(named: "likeItSelected"), for: .normal)
        }else {
            dislikeButton.setImage(UIImage(named: "orNotSelected"), for: .normal)
            likeButton.setImage(UIImage(named: "likeIt"), for: .normal)
        }
    }



    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



}
