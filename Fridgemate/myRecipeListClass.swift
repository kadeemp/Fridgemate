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

class myRecipeListClass: ViewController, UITableViewDataSource {
    
//    var userDefaults = NSUserDefaults.standardUserDefaults()
    
//    userDefaults.setObject(myPantryArray, forKey: "pantryList")
    var includedIngredients: [String] {
        return userDefaults.objectForKey("pantryList")! as! [String]
    }
    
    var headers: [String:String] = [:]
    var params: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headers = ["X-Mashape-Key":"Hppop5c3XNmsh6WS0tTXm2LrwB77p10grKmjsnWI5GNJIgOtvx"]
        
        params = [
            "includeIngredients":"\(includedIngredients)",
            "fillIngredients":"true"
        ]
        
        _ = Alamofire.request(.GET,"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients",headers: headers , parameters: params).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let recipeData = JSON(value)
                    
                    // print(recipeData)
                    let allRecipeData = recipeData["results"].arrayValue
                    var recipeArray: [RecipeData] = []
                    for i in 0..<allRecipeData.count {
                        //   let allRecipeData = recipeData["results"][i]
                        let tRecipes = RecipeData(json: allRecipeData[i])
                        // let tRecipes = RecipeData(json:recipeData )
                        recipeArray.append(tRecipes)
                        
                        
                    }
                    print()
                    print("____________________")
                    //print(recipeArray)
                }
                
            case .Failure(let error):
                print()
                print()
                print()
                print("--------------------------")
                print(error)
            }
        }
    }
   
    
    
    
    
//    func temp(){
//        userDefaults.setObject(recipeArray?, forKey: "pantryList")
//    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPantryArray = userDefaults.objectForKey("pantryList") as! [String]
        return myPantryArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        myPantryArray = userDefaults.objectForKey("pantryList") as! [String]
        let cell = UITableViewCell()
        let pantryList = myPantryArray[indexPath.row]
        cell.textLabel?.text = pantryList
        return cell
        
    }
    
}

