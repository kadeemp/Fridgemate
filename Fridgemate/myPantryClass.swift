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
   
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //for loop through all cells
        //if cell index matches indexToDelete, "delete" that cell by moving everything after it up 1
        //create new cell to occupy index 7 (must have 8 cells at all times)
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let indexToDelete = indexPath.row
            for i in 0..<(myPantryArray.count) {
                if i == indexToDelete {
                    for j in i..<(myPantryArray.count - 1) {
                        myPantryArray[j] = myPantryArray[j + 1]
                    }
                }
            }
            myPantryArray.removeAtIndex(myPantryArray.count - 1)
            
            //update and sync NSUserDefaults
            userDefaults.setObject(myPantryArray, forKey: "pantryList")
            userDefaults.synchronize()
            self.loadView()
            
        }
    }
    
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

    