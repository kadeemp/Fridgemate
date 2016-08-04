//
//  myPantryClass.swift
//  Fridgemate
//
//  Created by MakeSchool on 8/4/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//
import UIKit
import Foundation

class myPantryClass: ViewController ,UITableViewDataSource {
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPantryArray = userDefaults.objectForKey("pantryList") as! [String]
        return myPantryArray.count
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        myPantryArray = userDefaults.objectForKey("pantryList") as! [String]
        var cell = UITableViewCell()
        let pantryList = myPantryArray[indexPath.row]
        cell.textLabel?.text = pantryList
        return cell
        
    }
    
}
    
    