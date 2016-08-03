//
//  RecipeSetup.swift
//  Fridgemate
//
//  Created by MakeSchool on 8/2/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RecipeData {
    let recipeTitle: String
    let missingIngredientsNumber: Int
    let recipeID: Int
    let recipeImage: String
    
    init(json:JSON) {
        self.recipeTitle = json["title"].stringValue
         self.missingIngredientsNumber = json["missedIngredientCount"].intValue
         self.recipeID = json["id"].intValue
         self.recipeImage = json["image"].stringValue
        
//        self.recipeTitle = json["results"][0]["title"].stringValue
//         self.missingIngredientsNumber = json["results"][0]["missedIngredientCount"].intValue
//         self.recipeID = json["results"][0]["id"].intValue
//         self.recipeImage = json["results"][0]["image"].stringValue
    }
}