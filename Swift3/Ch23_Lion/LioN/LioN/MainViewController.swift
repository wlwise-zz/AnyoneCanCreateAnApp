//
//  ViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/24/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, AddEditViewControllerDelegate {
    var lionData : [Lion] = []
    var editIndexPath : IndexPath?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lionData.count
    }
    
    func addItemViewControllerDidCancel(controller: AddEditViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishEditingItem lionItem: Lion) {
        if let cell = tableView.cellForRow(at: editIndexPath!) {
            cell.textLabel?.text = lionItem.lionName
            cell.detailTextLabel?.text = lionItem.lionDescription
            
            lionData[editIndexPath!.row].lionDescription = lionItem.lionDescription
            lionData[editIndexPath!.row].lionName = lionItem.lionName
            lionData[editIndexPath!.row].like = lionItem.like
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishAddingItem lionItem: Lion) {
        print(lionItem.like)
        addItem(lionItem: lionItem)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            controller.delegate = self
        } else if segue.identifier == "edit" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.lionToEdit = lionData[indexPath.row]
                editIndexPath = indexPath
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lionCell", for: indexPath);
        cell.textLabel?.text = lionData[indexPath.row].lionName
        cell.detailTextLabel?.text = lionData[indexPath.row].lionDescription
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(lionData[indexPath.row].lionName)
    }
    
    func addItem(lionItem :  Lion) {
        let currentIndex = lionData.count
        lionData.append(lionItem)
        let indexPath = IndexPath(row: currentIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lionData.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

