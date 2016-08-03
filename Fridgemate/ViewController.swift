//
//  ViewController.swift
//  Fridgemate
//
//  Created by MakeSchool on 7/14/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    //TitleScreen
    @IBOutlet weak var TapToStartButton: UILabel!
    
    var counter: Double = 0.0
    var initialFontSize: CGFloat = 30.0
    
    //PantryEntryView
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var addIngredientTextField: UITextField!
    
    @IBAction func addIngredient(sender: AnyObject) {
       let text = addIngredientTextField.text
        myPantryArray.append(text!)
        addIngredientTextField.text="";
        print(myPantryArray)
       // saveText()
    }
    //MyPantryView
    var myPantryArray:[String] = []
    
    @IBOutlet weak var myPantryTextField: UITextView!
    
    func saveText() {
        for i in 0..<myPantryArray.count {
         myPantryTextField.text = myPantryArray[i]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let headers = [
            "X-Mashape-Key":"Hppop5c3XNmsh6WS0tTXm2LrwB77p10grKmjsnWI5GNJIgOtvx"
        ]
        let params = [
            "includeIngredients":"onions, basil, tomato"
        ]
        
        
        let request =  Alamofire.request(.GET,"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/searchComplex",headers: headers , parameters: params).validate().responseJSON() { response in
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
        
        
        
        
        
        let repeatingFunction: Selector = #selector(ViewController.pulseButton)
        _ = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: repeatingFunction, userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pulseButton() {
        counter += 1.0
        
        // calculate elapsed time
        let adjustmentFactor = (counter / 100.0) % 10.0
        var sizeAdjustment: Double = 0.0
        var alphaAdjustment: Double = 0.0
        
        // increase size and alpha
        if (adjustmentFactor < 5) {
            sizeAdjustment = (80.0 + 4.0 * adjustmentFactor) / 100.0
            alphaAdjustment = (40.0 + 12.0 * adjustmentFactor) / 100.0
        }
            // decrease size and alpha
        else {
            sizeAdjustment = (120.0 - 4.0 * adjustmentFactor) / 100.0
            alphaAdjustment = (160.0 - 12.0 * adjustmentFactor) / 100.0
        }
        
//        TapToStartButton.font =  UIFont(name: (TapToStartButton.font?.fontName)!, size: initialFontSize * CGFloat(sizeAdjustment))
//        TapToStartButton.alpha = CGFloat(alphaAdjustment)
    }
    
}



