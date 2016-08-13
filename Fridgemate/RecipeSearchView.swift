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
    
    @IBOutlet weak var searchBarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

        myPantryArray = viewController.myPantryArray
    }
    
    var includedIngredients: [String] {
        return userDefaults.objectForKey("pantryList")! as! [String]
    }
    
    /*var headers: [String:String] = [:]
     var params: [String:String] = [:]*/
    
   
    var recipeArrayHolder:[String] = []
    var stringRecipeListArray:[String] = []
    var stringRecipeListArray2:[String] = []
    
    let getURL = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex"
    
    @IBAction func SearchByIngredients(sender: AnyObject) {
        let typedIngredients = searchBarTextField.text  
        let headers = [
            "X-Mashape-Key":"Hppop5c3XNmsh6WS0tTXm2LrwB77p10grKmjsnWI5GNJIgOtvx"
        ]
        let params = [
            "ingredients":"\(typedIngredients)",
            //"fillIngredients":"true"
        ]
        
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients"
        
        //        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=apples%2Cflour%2Csugar&limitLicense=false&number=5&ranking=1"
        
        //        let url = NSURL(string: urlString)
        //        let session = NSURLSession.sharedSession()
        //        let mutableRequest = NSMutableURLRequest(URL: url!)
        //        mutableRequest.setValue("Hppop5c3XNmsh6WS0tTXm2LrwB77p10grKmjsnWI5GNJIgOtvx", forHTTPHeaderField: "X-Mashape-Key")
        //
        //        let task = session.dataTaskWithRequest(mutableRequest, completionHandler: { (data, response, error) -> Void in
        //            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        //        })
        //        task.resume()
        
        _ =  Alamofire.request(.GET,urlString,headers: headers, parameters: params).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let recipeData = JSON(value)
                    print(recipeData)
                    //                     var savedRecipeList: [String] = self.userDefaults.objectForKey("savedRecipeList") as! [String]
                    // print(recipeData)
                    let allRecipeData = recipeData.arrayValue
                    var recipeArray: [String] = []
                    for i in 0..<allRecipeData.count {
                        
                        let title = allRecipeData[i]["title"].rawString()

                        // let tRecipes = RecipeData(json:recipeData )
                        recipeArray.append(title!)
                        
                        // I want to save the given array
                        //             userDefaults.setObject(recipeArray, forKey: "savedRecipeList")
                        
                    }
                    self.userDefaults.setObject(recipeArray, forKey: "savedRecipeList")
                    print()
                    print("____________________")
                    print("000")
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
            "includeIngredients":"\(includedIngredientsString!)",
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
                    
                    let recipeListString  = recipeArray.joinWithSeparator(",")
                    self.userDefaults.setObject(recipeListString, forKey:"recipeList")
                    self.userDefaults.setObject(recipeArray, forKey: "savedRecipeList")
                    
                    print()
                    print("____________________")
                    
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



