//
//  ViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/12/15.
//  Copyright © 2015 Wendy Wise. All rights reserved.
//

import UIKit
import iAd

class MainViewController: UITableViewController {
    var bannerView: ADBannerView!
    var resultSearchController = UISearchController(searchResultsController: nil)
    var lionData : [Lion] = []
    var searchLionData : [Lion] = []
    var editIndexPath: NSIndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lionData.count == 0 {
            performSegueWithIdentifier("Intro", sender: self)
        }
        
        //iAd Support
        initializeAds()
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        self.definesPresentationContext = true
        
        //search bar functionality
        initializeSearchFeatuers()
        
        self.tableView.reloadData()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        lionData = [Lion]()
        searchLionData = [Lion]()
        loadLions()
    }
    
    func addItem(lionItem: Lion){
        let currentIndex = lionData.count
        lionData.append(lionItem)
        let indexPath = NSIndexPath(forRow: currentIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
//MARK: Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.resultSearchController.active){
            return self.searchLionData.count
        }else{
            return lionData.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("lionCell", forIndexPath: indexPath) as UITableViewCell
        var lion : Lion
        
        if (self.resultSearchController.active){
            lion = searchLionData[indexPath.row]
        } else{
            lion = lionData[indexPath.row]
        }
        
        if let nameLabel = cell.viewWithTag(1000) as? UILabel {
            nameLabel.text = lion.lionName
        }
        
        if let descriptionLabel = cell.viewWithTag(1001) as? UILabel {
            descriptionLabel.text = lion.lionDescription
        }
        
        if let cellImageView = cell.viewWithTag(1002) as? UIImageView{
            if lion.like == 1{
                cellImageView.image =   UIImage(imageLiteral: "likeItCell")
            }else{
                cellImageView.image =  UIImage(imageLiteral: "orNotCell")
            }
        }
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
            resetSearchBar()
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            controller.delegate = self
        } else  if segue.identifier == "Intro" {
            let vc = segue.destinationViewController
            let controller = vc.popoverPresentationController
            
            if controller != nil{
                controller?.delegate = self
            }
        }
        else if segue.identifier == "Edit"{
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                if (resultSearchController.active){
                    controller.lionToEdit = searchLionData[indexPath.row]
                    editIndexPath = indexPath
                }else{
                  controller.lionToEdit = lionData[indexPath.row]
                  editIndexPath = indexPath
                }
            }
            controller.delegate = self
        }
    }
    
//MARK: Saving and Loading
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
    }
}


//MARK:  AddEditView Controller Delegate
extension MainViewController : AddEditViewControllerDelegate{
    func addItemViewControllerDidCancel(controller: AddEditViewController) {
        dismissViewControllerAnimated(true, completion: nil)
        resetSearchBar()
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishEditingItem lionItem: Lion) {
        if let cell = tableView.cellForRowAtIndexPath(editIndexPath!) {
            if let nameLabel = cell.viewWithTag(1000) as? UILabel {
                nameLabel.text = lionItem.lionName
            }
            
            if let descriptionLabel = cell.viewWithTag(1001) as? UILabel {
                descriptionLabel.text = lionItem.lionDescription
            }
            
            lionData[editIndexPath!.row].lionDescription = lionItem.lionDescription
            lionData[editIndexPath!.row].lionName = lionItem.lionName
            lionData[editIndexPath!.row].like = lionItem.like
            lionData[editIndexPath!.row].lionNotes = lionItem.lionNotes
            if let cellImageView = cell.viewWithTag(1002) as? UIImageView{
                if lionData[editIndexPath!.row].like == 1{
                    cellImageView.image =   UIImage(imageLiteral: "likeItCell")
                }else{
                    cellImageView.image =  UIImage(imageLiteral: "orNotCell")
                }
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        resetSearchBar()
        saveLionItems()
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishAddingItem lionItem: Lion) {
        addItem(lionItem)
        dismissViewControllerAnimated(true, completion: nil)
        saveLionItems()
    }
}
//MARK: Ad Stuff
    extension MainViewController :ADBannerViewDelegate {
        func initializeAds(){
            self.canDisplayBannerAds = true
            bannerView = ADBannerView(adType: .Banner)
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            bannerView.delegate = self
            bannerView.hidden = true
            self.view.addSubview(bannerView)
        }
        
        func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
            return willLeave
        }
        
        func bannerViewDidLoadAd(banner: ADBannerView!) {
            bannerView.hidden = false
        }
        
        func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
            bannerView.hidden = true
            print("error in the ad stuff")
        }

    }
//MARK: SearchBar
extension MainViewController : UISearchBarDelegate, UISearchControllerDelegate , UISearchResultsUpdating {
    func initializeSearchFeatuers(){
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.scopeButtonTitles = ["LioN: Name", "Description", "Notes"]
        resultSearchController.searchBar.delegate = self
        tableView.tableHeaderView = resultSearchController.searchBar
    }

    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResultsForSearchController(resultSearchController)
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        searchLionData.removeAll(keepCapacity: false)
        filterLioNsforSearchText(searchController.searchBar.text!)
        self.tableView.reloadData()
    }
    
    func resetSearchBar(){
        resultSearchController.active = false
        resultSearchController.searchBar.text = ""
    }

    func filterLioNsforSearchText(searchedText: String) {
        self.searchLionData = self.lionData.filter({(lion:Lion) -> Bool in
            if (resultSearchController.searchBar.selectedScopeButtonIndex == 0){
                
                let stringMatch = lion.lionName.uppercaseString.rangeOfString(searchedText.uppercaseString)
                return stringMatch != nil
            } else if(resultSearchController.searchBar.selectedScopeButtonIndex == 1) {
                let stringMatch = lion.lionDescription.uppercaseString.rangeOfString(searchedText.uppercaseString)
                return stringMatch != nil
            }else {
                let stringMatch = lion.lionNotes.uppercaseString.rangeOfString(searchedText.uppercaseString)
                return stringMatch != nil
            }
        })
    }
}

extension MainViewController : UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
}

