//
//  ViewController.swift
//  LioN
//
//  Created by Wendy Wise on 9/24/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    var lionData : [Lion] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLionDetail" {
            let controller = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                controller.lionDetail = lionData[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lionData.count
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
    
    @IBAction func addItem(_ sender: AnyObject) {
        print("add clicked")
        let currentIndex = lionData.count
        let newLion = Lion()
        newLion.like = false
        newLion.lionName = "hard coded name"
        newLion.lionDescription = "hard coded description"
        lionData.append(newLion)
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
        let toothpasteLion = Lion()
        toothpasteLion.lionName = "Wendy's Toothpaste"
        toothpasteLion.lionDescription = "the one in the blue box"
        toothpasteLion.like = true
        lionData.append(toothpasteLion)
        
        let toothpasteLion2 = Lion()
        toothpasteLion2.lionName = "Wendy's Bad Toothpaste"
        toothpasteLion2.lionDescription = "the one in the red box"
        toothpasteLion2.like = false
        lionData.append(toothpasteLion2)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

