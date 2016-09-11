//
//  ViewController.swift
//  PizzaIngredients
//
//  Created by Wendy Wise on 9/11/16.
//  Copyright © 2016 WisaAbility. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    typealias ingredient = (name: String, desc : String, calories: String, fat : String)
    var ingredients : [ingredient] = []
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row].name
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ingredients.count
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let pepperoni : ingredient = ("Pepperoni", "yummy goodness", "probably none", "less than 0 percent")
        let cheese: (ingredient) = ("cheese", "yummy gooeyness", "less than 0 calories", "less than 0 percent")
        ingredients.append(pepperoni)
        ingredients.append(cheese)
        print(ingredients[0].name)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

