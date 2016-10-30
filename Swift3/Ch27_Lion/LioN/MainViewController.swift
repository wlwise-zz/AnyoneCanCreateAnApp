//
//  ViewController.swift
//  LioN
//
//  Created by Wendy Wise on 10/1/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, AddEditViewControllerDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    var searchLionData : [Lion] = []

    var lionData : [Lion] = []
    var editIndexPath: NSIndexPath?
    var resultSearchController = UISearchController(searchResultsController: nil)

    func updateSearchResults(for searchController: UISearchController){
        print ("update search results called")
        filterLioNsforSearchText(searchedText: searchController.searchBar.text!)
        self.tableView.reloadData()


    }

    func filterLioNsforSearchText(searchedText: String) {
        self.searchLionData = self.lionData.filter({(lion: Lion) -> Bool in
            if (resultSearchController.searchBar.selectedScopeButtonIndex == 0){
                let stringMatch = lion.lionName.uppercased().range(of: searchedText.uppercased())
                return stringMatch != nil
            }else{
                let stringMatch = lion.lionDescription.uppercased().range(of: searchedText.uppercased())
                return stringMatch != nil
            }
        })
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: resultSearchController)
    }


    func resetSearchBar(){
        resultSearchController.isActive = false
        resultSearchController.searchBar.text = ""
    }


    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lionData = [Lion]()
        loadLions()
        
    }
    func loadLions(){
        let path = getDataFilePath()
        if let data =  try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            lionData = unarchiver.decodeObject(forKey: "lionData") as! [Lion]
            unarchiver.finishDecoding()
        }
    }
    
    func saveLionItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lionData, forKey: "lionData")
        archiver.finishEncoding()
        data.write(to: getDataFilePath(), atomically: true)
    }
    
    func addItemViewControllerDidCancel(controller: AddEditViewController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishAddingItem lionItem: Lion) {
        addItem(lionItem: lionItem)
        dismiss(animated: true, completion: nil)
        saveLionItems()
    }
    
    func addItemViewController(controller: AddEditViewController, didFinishEditingItem lionItem: Lion) {
        if let cell = tableView.cellForRow(at: editIndexPath! as IndexPath){
            cell.textLabel?.text = lionItem.lionName
            cell.detailTextLabel?.text = lionItem.lionDescription
            
            lionData[editIndexPath!.row].lionDescription = lionItem.lionDescription
            lionData[editIndexPath!.row].lionName = lionItem.lionName
            lionData[editIndexPath!.row].like = lionItem.like
            if (lionData[editIndexPath!.row].like == 1){
                cell.imageView!.image = UIImage(named: "likeItCell")
                
            }else {
                cell.imageView!.image = UIImage(named: "orNotCell")
            }
        }
        saveLionItems()
        dismiss(animated: true, completion: nil)
    }
    
    
    func addItem(lionItem :  Lion) {
        let currentIndex = lionData.count
        lionData.append(lionItem)
        let indexPath = IndexPath(row: currentIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddEditViewController
            controller.delegate = self
        } else if segue.identifier == "edit"{
                let navigationController = segue.destination as! UINavigationController
                let controller = navigationController.topViewController as! AddEditViewController
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    if (resultSearchController.isActive){
                        controller.lionToEdit = searchLionData[indexPath.row]
                        editIndexPath = indexPath as NSIndexPath?
                    }else{
                        controller.lionToEdit = lionData[indexPath.row]
                        editIndexPath = indexPath as NSIndexPath?
                    }
                }
                controller.delegate = self
            } 
        }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (self.resultSearchController.isActive){
            return searchLionData.count
        }else{
            return lionData.count
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lionData.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var lion : Lion
        if (self.resultSearchController.isActive){
            lion = searchLionData[indexPath.row]
        }else{
            lion = lionData[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "lionCell", for: indexPath);
        
        cell.textLabel?.text = lion.lionName
        cell.detailTextLabel?.text = lion.lionDescription
        if lion.like == 1{
            cell.imageView?.image =   UIImage(named: "likeItCell")
        }else{
            cell.imageView?.image =  UIImage(named: "orNotCell")
        }
        return cell
    }
    
    func getDataFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("Lion.plist")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getDataFilePath())
        resultSearchController.searchResultsUpdater = self
        resultSearchController.searchBar.delegate = self
        tableView.tableHeaderView = resultSearchController.searchBar
        self.definesPresentationContext = true
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.scopeButtonTitles = ["LioN: Name", "Description"]

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

