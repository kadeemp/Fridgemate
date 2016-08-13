//
//  PantryEntryClass.swift
//  Fridgemate
//
//  Created by MakeSchool on 8/8/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import Foundation
import UIKit

class pantryEntryClass:  UIViewController {
    
    
    
    let viewController = ViewController()
    var myPantryArray: [String] = []
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPantryArray = viewController.myPantryArray
    }
    
 
    
    @IBOutlet weak var addIngredientButton: UIButton!
    
    @IBOutlet weak var addIngredientTextField: UITextField!
    
    @IBAction func addIngredient(sender: AnyObject) {
        myPantryArray = userDefaults.objectForKey("pantryList") as! [String]
        var text = addIngredientTextField.text
        
        if addIngredientTextField.text != "" {
            for c in (addIngredientTextField.text?.characters)! {
                if c != " " {
                    text = text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                    myPantryArray.append(text!)
                    break
                }
            }
        }
        
        addIngredientTextField.text="";
        
        print(myPantryArray)
         userDefaults.setObject(myPantryArray, forKey: "pantryList")
        
        let pantryListString  = myPantryArray.joinWithSeparator(",")
        
        self.userDefaults.setObject(pantryListString, forKey:"includedIngredients")
        
  
    }
}