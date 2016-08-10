//
//  myRecipeListClass.swift
//  Fridgemate
//
//  Created by MakeSchool on 8/4/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class myRecipeListClass: recipeSearchClass, UITableViewDataSource {
    
    
    @IBAction func refresh(sender: AnyObject) {
        self.loadView()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         stringRecipeListArray = userDefaults.objectForKey("savedRecipeList") as! [String]
        return stringRecipeListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        stringRecipeListArray = userDefaults.objectForKey("savedRecipeList") as! [String]
        let cell = UITableViewCell()
        let recipeList = stringRecipeListArray[indexPath.row]
        cell.textLabel?.text = recipeList
        
        
        return cell
        
        
    }
    // userDefaults.setObject(myPantryArray, forKey: "pantryList")
    
    //    var includedIngredients: [String] {
    //        return userDefaults.objectForKey("pantryList")! as! [String]
}

