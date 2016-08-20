//
//  ViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/12/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    var lionData : [Lion] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let toothpasteLion = Lion()
        toothpasteLion.lionName = "Wendy's toothpaste"
        toothpasteLion.lionDescription = "the one in the blue box"
        toothpasteLion.like = 1
        lionData.append(toothpasteLion)
        
        let toothpasteLion2 = Lion()
        toothpasteLion2.lionName = "bad toothpaste"
        toothpasteLion2.lionDescription = "the one in the red box"
        toothpasteLion2.like = 0
        lionData.append(toothpasteLion2)
    }
    
    @IBAction func addItem(){
        let currentIndex = lionData.count
        let newLion = Lion()
        newLion.like = 1
        newLion.lionDescription = "Hard coded description"
        newLion.lionName = "hard coded name"
        lionData.append(newLion)
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
        if (segue.identifier == "showLionDetail"){
            let controller = segue.destinationViewController as! AddEditViewController
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                controller.lionDetail = lionData[indexPath.row]
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

