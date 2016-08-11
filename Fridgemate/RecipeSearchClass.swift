//
//  RecipeSearchClass.swift
//  Fridgemate
//
//  Created by MakeSchool on 8/4/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class recipeSearchClass: UIViewController {
    
    let viewController = ViewController()
    var myPantryArray: [String] = []
    var userDefaults = NSUserDefaults.standardUserDefaults()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myPantryArray = viewController.myPantryArray
    }
    
    var includedIngredients: [String] {
        return userDefaults.objectForKey("pantryList")! as! [String]
    }
    
    /*var headers: [String:String] = [:]
     var params: [String:String] = [:]*/
    
    let headers = [
        "X-Mashape-Key":"Hppop5c3XNmsh6WS0tTXm2LrwB77p10grKmjsnWI5GNJIgOtvx"
    ]
    let params = [
        "ingredients":"onions, tomato, eggplant, basil",
        "fillIngredients":"true"
    ]
    var recipeArrayHolder:[String] = []
    var stringRecipeListArray:[String] = []
    var stringRecipeListArray2:[String] = []
    
    let getURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex"
    
    @IBAction func SearchByIngredients(sender: AnyObject) {
        // = userDefaults.objectForKey("pantryList") as! [String]
        _ =  Alamofire.request(.GET,getURL,headers: headers , parameters: params).validate().responseString() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let recipeData = JSON(value)
                    let allRecipeData = recipeData["results"].arrayValue
                    var recipeTitleArray: [String] = []
                    for i in 0..<allRecipeData.count {
                        let title = allRecipeData[i]["title"].rawString()
                        recipeTitleArray.append(title!)
                    }
                    let includedIngredientsString  = recipeTitleArray.joinWithSeparator(",")
                    self.userDefaults.setObject(includedIngredientsString, forKey:"includedIngredients")
                    self.userDefaults.setObject(recipeTitleArray, forKey: "savedRecipeList")
                    
                    print()
                    print("____________________")
                    print(recipeTitleArray)
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
    
    @IBAction func SearchByPantry(sender: AnyObject) {
        //self.recipeListTable.reloadData()
        
        let includedIngredientsString = userDefaults.objectForKey("includedIngredients")
        let headers = [
            "X-Mashape-Key":"Hppop5c3XNmsh6WS0tTXm2LrwB77p10grKmjsnWI5GNJIgOtvx"
        ]
        let params = [
            "includeIngredients":"\(includedIngredientsString)",
            "fillIngredients":"true"
        ]
        
        _ =  Alamofire.request(.GET,"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex",headers: headers , parameters: params).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let recipeData = JSON(value)
                    let allRecipeData = recipeData["results"].arrayValue
                    var recipeTitleArray: [String] = []
                    for i in 0..<allRecipeData.count {
                        let title = allRecipeData[i]["title"].rawString()
                        recipeTitleArray.append(title!)
                    }
                    
                    let recipeTitleString  = recipeTitleArray.joinWithSeparator(",")
                    self.userDefaults.setObject(recipeTitleString, forKey:"recipeTitleList")
                    self.userDefaults.setObject(recipeTitleArray, forKey: "savedRecipeList")
                    
                    print()
                    print("____________________")
                    print(recipeTitleString)
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
}



