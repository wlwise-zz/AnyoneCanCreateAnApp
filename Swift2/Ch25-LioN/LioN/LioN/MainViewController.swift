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
    var editIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath())
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        lionData = [Lion]()
        loadLions()
    }
    
    func addItemViewControllerDidCancel(controller: AddEditViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishEditingItem lionItem: Lion) {
            if let cell = tableView.cellForRowAtIndexPath(editIndexPath!) {
                cell.textLabel?.text = lionItem.lionName
                cell.detailTextLabel?.text = lionItem.lionDescription
                lionData[editIndexPath!.row].lionDescription = lionItem.lionDescription
                lionData[editIndexPath!.row].lionName = lionItem.lionName
                lionData[editIndexPath!.row].like = lionItem.like
            }
        dismissViewControllerAnimated(true, completion: nil)
        saveLionItems()
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishAddingItem lionItem: Lion) {
        addItem(lionItem)
        print(lionItem.like)
        dismissViewControllerAnimated(true, completion: nil)
        saveLionItems()
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
        saveLionItems()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Add"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            controller.delegate = self
        } else if segue.identifier == "Edit"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.lionToEdit = lionData[indexPath.row]
                editIndexPath = indexPath
            }
            controller.delegate = self
        }
    }
    
    func saveLionItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lionData, forKey: "lionData")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadLions(){
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lionData = unarchiver.decodeObjectForKey("lionData") as! [Lion]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func dataFilePath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0].stringByAppendingString("/lion.plist")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

