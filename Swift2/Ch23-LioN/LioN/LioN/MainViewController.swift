//
//  ViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/12/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, AddEditViewControllerDelegate {
    var lionData : [Lion] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addItemViewControllerDidCancel(controller: AddEditViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishAddingItem lionItem: Lion) {
        addItem(lionItem)
        print(lionItem.like)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItem(lionItem: Lion){
        let currentIndex = lionData.count
        lionData.append(lionItem)
        let indexPath = NSIndexPath(forRow: currentIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return lionData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("lionCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = lionData[indexPath.row].lionName
        cell.detailTextLabel?.text = lionData[indexPath.row].lionDescription
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        lionData.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Add"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            controller.delegate = self
        } else if segue.identifier == "Edit"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            controller.delegate = self
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

