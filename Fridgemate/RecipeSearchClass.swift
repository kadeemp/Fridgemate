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
        let request =  Alamofire.request(.GET,getURL,headers: headers , parameters: params).validate().responseString() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let recipeData = JSON(value)
                    //                     var savedRecipeList: [String] = self.userDefaults.objectForKey("savedRecipeList") as! [String]
                    // print(recipeData)
                    let allRecipeData = recipeData.arrayValue
                    var recipeArray: [RecipeData] = []
                    for i in 0..<allRecipeData.count {
                        //   let allRecipeData = recipeData["results"][i]
                        let tRecipes = RecipeData(json: allRecipeData[i])
                        // let tRecipes = RecipeData(json:recipeData )
                        recipeArray.append(tRecipes)
                        // I want to save the given array
                        //             userDefaults.setObject(recipeArray, forKey: "savedRecipeList")
                        
                    }
                    print()
                    print("____________________")
                    print(recipeArray)
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
        
    var includedIngredientsString = userDefaults.objectForKey("includedIngredients")
        let headers = [
            "X-Mashape-Key":"Hppop5c3XNmsh6WS0tTXm2LrwB77p10grKmjsnWI5GNJIgOtvx"
        ]
        let params = [
            "includeIngredients":"\(includedIngredientsString)",
            "fillIngredients":"true"
        ]
        
        let request =  Alamofire.request(.GET,"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex",headers: headers , parameters: params).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let recipeData = JSON(value)
                    //                     var savedRecipeList: [String] = self.userDefaults.objectForKey("savedRecipeList") as! [String]
                    // print(recipeData)
                    let allRecipeData = recipeData["results"].arrayValue
                    var recipeArray: [String] = []
                    for i in 0..<allRecipeData.count {
                        
                        let title = allRecipeData[i]["title"].rawString()
                        
                        //   let allRecipeData = recipeData["results"][i]
                       // let tRecipes = RecipeTitle(json: allRecipeData[i])
                        // let tRecipes = RecipeData(json:recipeData )
                        recipeArray.append(title!)
                        
                        
                    }
                    
                    let includedIngredientsString  = recipeArray.joinWithSeparator(",")
                    self.userDefaults.setObject(includedIngredientsString, forKey:"includedIngredients")
                    self.userDefaults.setObject(recipeArray, forKey: "savedRecipeList")
                    
                    print()
                    print("____________________")
                    print("It worked")
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



